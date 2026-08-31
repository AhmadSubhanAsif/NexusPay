import Foundation
import Combine

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isPasswordVisible = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    var canSubmit: Bool {
        isValidEmail && password.count >= 8
    }

    private var isValidEmail: Bool {
        email.contains("@") && email.contains(".")
    }

    func signIn() {
        errorMessage = nil

        guard canSubmit else {
            errorMessage = "Enter a valid email and a password with at least 8 characters."
            return
        }

        // Replace this with AuthRepository.signIn(email:password:).
        isLoading = true

        Task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            isLoading = false

            // Route to the authenticated flow after successful API sign-in.
        }
    }
}
