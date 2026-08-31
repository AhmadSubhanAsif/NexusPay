import SwiftUI

struct SignInView: View {
    
    let onCreateAccount: () -> Void
    @StateObject private var viewModel = SignInViewModel()
    
    init(onCreateAccount: @escaping () -> Void = {}) {
           self.onCreateAccount = onCreateAccount
       }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer(minLength: 56)
                
                VStack(spacing: 10) {
                    Image(systemName: "building.columns.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.blue)
                    
                    Text("NexusPay")
                        .font(.system(size: 32, weight: .bold))
                    
                    Text("Secure payments, simply.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                NexusTextField(
                    title: "Email address",
                    placeholder: "name@example.com",
                    text: $viewModel.email,
                    systemImage: "envelope",
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    autocapitalization: .never,
                    autocorrectionDisabled: true
                )
                
                NexusPasswordField(
                    title: "Password",
                    placeholder: "Enter your password",
                    password: $viewModel.password,
                    isPasswordVisible: $viewModel.isPasswordVisible
                )

                if let errorMessage = viewModel.errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                NexusPrimaryButton(
                    title: "Sign in",
                    isLoading: viewModel.isLoading,
                    isDisabled: !viewModel.canSubmit
                ){
                    viewModel.signIn()
                }

                HStack(spacing: 4) {
                    Text("New to NexusPay?")
                        .foregroundStyle(.secondary)

                    Button("Create an account") {
                        onCreateAccount()
                    }
                    .fontWeight(.semibold)
                }
                .font(.footnote)
                
            }
            .padding(24)
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
        }
    }
}
