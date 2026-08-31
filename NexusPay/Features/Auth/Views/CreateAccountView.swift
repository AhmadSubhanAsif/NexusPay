import SwiftUI

struct CreateAccountView: View {
    
    let onSignIn: () -> Void

    @StateObject private var viewModel = CreateAccountViewModel()
    
    init(onSignIn: @escaping () -> Void = {}) {
           self.onSignIn = onSignIn
       }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 10) {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)

                    Text("Create account")
                        .font(.system(size: 30, weight: .bold))

                    Text("Enter your details to get started.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 24)
                
                
                VStack(spacing: 18){
                    NexusTextField(
                        title: "First name",
                        placeholder: "Ahmad",
                        text: $viewModel.firstName,
                        systemImage: "person",
                        textContentType: .givenName,
                        autocapitalization: .words
                    )
                    
                    NexusTextField(
                        title: "Last name",
                        placeholder: "Asif",
                        text: $viewModel.lastName,
                        systemImage: "person",
                        textContentType: .familyName,
                        autocapitalization: .words
                    )
                    
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
                    
                    NexusTextField(
                        title: "Phone number",
                        placeholder: "+44 7000 000000",
                        text: $viewModel.phone,
                        systemImage: "phone",
                        keyboardType: .phonePad,
                        textContentType: .telephoneNumber,
                        autocapitalization: .never
                    )
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text("Date of birth")
                            .font(.subheadline.weight(.medium))
                        
                        DatePicker("Date of birth", selection: $viewModel.dateOfBirth,
                        in: ...Date(),
                        displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nationality")
                            .font(.subheadline.weight(.medium))

                        Picker("", selection: $viewModel.nationality) {
                            Text("Select nationality").tag("")

                            ForEach(viewModel.nationalities, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    NexusPasswordField(
                        title: "Password",
                        placeholder: "At least 8 characters",
                        password: $viewModel.password,
                        isPasswordVisible: $viewModel.isPasswordVisible
                    )
                    
                    NexusPasswordField(
                        title: "Confirm password",
                        placeholder: "Enter password again",
                        password: $viewModel.confirmPassword,
                        isPasswordVisible: $viewModel.isConfirmPasswordVisible
                        )
                    
                    Toggle(isOn: $viewModel.hasAcceptedTerms) {
                        Text("I agree to the Terms and Privacy Policy")
                            .font(.footnote)
                    }
                    .tint(.blue)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    NexusPrimaryButton(
                        title: "Create account",
                        isLoading: viewModel.isLoading,
                        isDisabled: !viewModel.canSubmit
                    ) {
                        viewModel.createAccount()
                        }
                }
                
                
                HStack(spacing: 4) {
                    Text("Already have an account?")
                    .foregroundStyle(.secondary)

                    Button("Sign in") {
                        onSignIn()                    }
                    .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .padding(.bottom, 24)
                
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Create account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateAccountView()
        }
    }
}
