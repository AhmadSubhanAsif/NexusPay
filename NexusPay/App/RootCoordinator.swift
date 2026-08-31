import Combine

@MainActor
final class RootCoordinator: ObservableObject {
    @Published var rootRoute: AppRoute = .signIn
    @Published var path: [AppRoute] = []

    func show(_ route: AppRoute) {
        path.append(route)
    }

    func reset(to route: AppRoute) {
        rootRoute = route
        path.removeAll()
    }
    
    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
