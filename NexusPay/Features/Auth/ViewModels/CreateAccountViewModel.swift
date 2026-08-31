import Foundation
import Combine

@MainActor
final class CreateAccountViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var dateOfBirth = Calendar.current.date(
        byAdding: .year,
        value: -18,
        to: Date()
    ) ?? Date()
    @Published var nationality = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isPasswordVisible = false
    @Published var isConfirmPasswordVisible = false
    @Published var hasAcceptedTerms = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    let nationalities = [
        "United Kingdom",
        "Pakistan",
        "United States",
        "United Arab Emirates"
    ]

    var canSubmit: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespaces).isEmpty &&
        isValidEmail &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !nationality.isEmpty &&
        password.count >= 8 &&
        password == confirmPassword &&
        hasAcceptedTerms
    }

    private var isValidEmail: Bool {
        email.contains("@") && email.contains(".")
    }

    func createAccount() {
        errorMessage = nil

        guard canSubmit else {
            errorMessage = "Please complete all required fields and confirm your password."
            return
        }

        isLoading = true

        Task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            isLoading = false

            // Later: call AuthRepository.createAccount(...)
            // Then route back to Sign in or KYC, based on backend behaviour.
        }
    }
}
