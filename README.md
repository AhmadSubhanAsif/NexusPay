# NexusPay

NexusPay is an iPhone-first fintech application planned in SwiftUI. The mobile app is a secure client of a server-authoritative financial ledger: it displays account state and submits tracked commands, but it never treats local data as the ledger of record.

## Architecture goal

Build a modular, testable iOS app that can safely handle authentication, KYC, wallets, transaction history, and asynchronous transfers. The app should remain usable under unreliable networks and must never create a duplicate transfer after a retry, timeout, or restart.

## Technology baseline

- Swift 6.3, Xcode 26.4, minimum deployment target: iOS 17
- SwiftUI with `NavigationStack` and Observation (`@Observable`)
- Swift Concurrency: `async`/`await`, actors, and `Sendable` value types
- URLSession and Codable for networking
- Keychain for credentials and protected files for sensitive local state
- SQLite/GRDB behind a storage protocol for a small, encrypted cache and command journal
- Swift Testing for domain/data tests; XCTest for UI and performance tests
- OSLog and MetricKit with privacy-safe telemetry

## Module layout

Use feature modules with a clean domain boundary rather than one large MVVM folder.

```text
NexusPayApp/                 App entry point and dependency composition
CoreDomain/                  Entities, validation, errors, use-case protocols
CoreData/                    API client, DTO mapping, Keychain, SQLite, repositories
DesignSystem/                Shared accessible UI controls and screen states
Features/
  Auth/                      Sign in, registration, session-expired state
  KYC/                       KYC onboarding, status, and resubmission
  Wallet/                    Dashboard, activity, transaction detail
  Transfer/                  Draft, confirmation, submission, reconciliation
  Notifications/             Inbox, push/deep-link routing
```

Dependency direction is deliberate:

```text
SwiftUI screens -> screen models -> CoreDomain protocols <- CoreData implementations
```

Views do not call `URLSession`, Keychain, SQLite, or concrete DTOs. The app composition root is the only place that creates concrete services.

## Set-up steps

### 1. Stabilize the mobile API contract

Before connecting production UI to the backend, publish a versioned `/v1` OpenAPI contract with example success and error responses. The required production additions are:

- Refresh and logout endpoints with revocation support
- Private KYC uploads via presigned upload or multipart API
- `GET /v1/wallets/me` and authenticated ownership checks
- Transfer idempotency with `Idempotency-Key`
- Transfer lookup by ID and idempotency key for reconciliation
- Cursor-based transaction history

Do not release transfer functionality until caller authorization, wallet ownership validation, idempotency, limits, audit records, and stable status codes are enforced server-side.

### 2. Create the Xcode project and targets

Create an iOS 17+ SwiftUI application and add the module/target boundaries above. Add unit-test and UI-test targets immediately. Keep development, staging, and production configuration separate; never hard-code localhost or credentials in a release build.

### 3. Establish the app shell

Implement typed `AppRoute` values, a root coordinator, dependency container, feature flags, OSLog categories, and reusable loading, empty, offline, and error states. Previews and tests must run without network access through injected fakes.

### 4. Define domain contracts first

Create framework-light entities and protocols for authentication, KYC, wallet data, transactions, local storage, and transfers. Keep money validation, route guards, and transfer state transitions unit-testable without SwiftUI or networking.

### 5. Add secure session and recovery foundations

Use a `SessionActor` as the sole owner of token metadata stored in Keychain. Add protected local storage for a small recovery snapshot, form drafts, cache records, and the transfer command journal. Never put tokens, KYC images, or financial data in UserDefaults, SceneStorage, logs, or analytics.

### 6. Build in product order

1. API contract and configuration
2. App shell and design system
3. Authentication and secure sessions
4. KYC onboarding and account activation
5. Wallet dashboard and paginated history
6. Safe transfers and reconciliation
7. Notifications, deep links, and observability
8. QA, security hardening, beta, and release readiness

## Transfer safety rules

Transfers are asynchronous and server-authoritative. The client must:

- Validate locally for feedback, but never authorize from a cached balance.
- Create and persist an idempotency key plus encrypted command-journal record before sending a transfer.
- Disable duplicate submission.
- Treat timeouts, disconnects, and restarts as `UNKNOWN`, then reconcile with the server using the existing idempotency key or transfer reference.
- Never resend a transfer automatically after a timeout or app restart.
- Only display success after the server reports a terminal `COMPLETED` state.

Suggested state flow:

```text
DRAFT -> READY_TO_CONFIRM -> SUBMITTING -> PENDING -> COMPLETED | FAILED
                                  |
                                  +-> UNKNOWN -> reconcile -> PENDING | COMPLETED | FAILED
```

## Security and quality gates

- Keep tokens in Keychain; use TLS; redact logs at the source.
- Do not log tokens, account IDs, KYC data, addresses, document URLs, or full payloads.
- Gate wallet and transfer navigation on server-verified session, KYC, and wallet-lock state.
- Page history data; label cached data with its last-updated time.
- Cover financial validation and transfer state-machine branches completely with tests.
- Test network loss, 401 refresh behavior, rate limiting, KYC denial, duplicate taps, transfer timeouts, and app termination during submission.
- Complete accessibility, privacy, threat-model, performance, staging contract, and rollback checks before beta release.

## Current priority

Start with Phase 0: agree and publish the versioned mobile API contract. Once the transfer idempotency and reconciliation contract is approved, build the app shell and design system against fakes while backend work continues.
