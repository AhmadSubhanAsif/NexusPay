import SwiftUI

struct NexusPasswordField: View {
    let title: String
    let placeholder: String

    @Binding var password: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.medium))

            HStack(spacing: 12) {
                Image(systemName: "lock")
                    .foregroundStyle(.secondary)

                Group {
                    if isPasswordVisible {
                        TextField(placeholder, text: $password)
                    } else {
                        SecureField(placeholder, text: $password)
                    }
                }
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel(isPasswordVisible ? "Hide password" : "Show password")
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
