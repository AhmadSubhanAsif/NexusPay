import Foundation

/// The only location where live repository implementations will be composed.
/// Features receive domain protocols rather than networking or storage details.
@MainActor
final class AppDependencyContainer {
    let featureFlags: FeatureFlags

    init(featureFlags: FeatureFlags = .default) {
        self.featureFlags = featureFlags
    }
}
