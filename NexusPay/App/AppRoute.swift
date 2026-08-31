import Foundation

enum AppRoute: Hashable {
    case signIn
    case createAccount
    case home
    case kycStatus
    case transactionHistory
    case transfer
    case notifications
    case profile

    var title: String {
        switch self {
        case .signIn: return "Sign in"
        case .createAccount: return "Create account"
        case .home: return "Wallet"
        case .kycStatus: return "Verification"
        case .transactionHistory: return "Activity"
        case .transfer: return "Transfer"
        case .notifications: return "Notifications"
        case .profile: return "Profile"
        }
    }
}
