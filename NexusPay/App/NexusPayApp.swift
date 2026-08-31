import SwiftUI

@main
@MainActor
struct NexusPayApp: App {
    @State private var coordinator = RootCoordinator()

    var body: some Scene {
        WindowGroup {
            AppRootView(coordinator: coordinator)
        }
    }
}

private struct AppRootView: View {
    @ObservedObject var coordinator: RootCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                switch coordinator.rootRoute {
                case .signIn:
                    SignInView {
                           coordinator.show(.createAccount)
                       }
                case .home:
                    ContentUnavailableView(
                        "Wallet",
                        systemImage: "creditcard",
                        description: Text("Wallet data will be supplied by a server-authoritative repository.")
                    )
                default:
                    ContentUnavailableView(
                        "NexusPay",
                        systemImage: "building.columns",
                        description: Text("This route is available after secure session and account checks.")
                    )
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .createAccount:
                    CreateAccountView {
                        coordinator.goBack()
                    }

                default:
                    Text(route.title)
                }
            }
        }
    }
}
