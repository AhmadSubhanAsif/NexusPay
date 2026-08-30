//
//  SignInView.swift
//  NexusPay
//
//  Created by Macbook on 30/08/2026.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()

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
