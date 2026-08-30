import SwiftUI
import UIKit

struct NexusTextField: View {
    let title: String
    let placeholder: String
    let systemImage: String?
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let autocapitalization: TextInputAutocapitalization?
    let autocorrectionDisabled: Bool

    @Binding var text: String

    init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        systemImage: String? = nil,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        autocapitalization: TextInputAutocapitalization? = .sentences,
        autocorrectionDisabled: Bool = false
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.systemImage = systemImage
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.medium))

            HStack(spacing: 12) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(.secondary)
                }

                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textInputAutocapitalization(autocapitalization)
                    .autocorrectionDisabled(autocorrectionDisabled)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
