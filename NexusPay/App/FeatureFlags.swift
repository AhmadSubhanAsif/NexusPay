import Foundation

struct FeatureFlags: Sendable {
    let refreshSessionEnabled: Bool
    let secureKYCUploadEnabled: Bool
    let transferEnabled: Bool
    let pushNotificationsEnabled: Bool

    static let `default` = FeatureFlags(
        refreshSessionEnabled: false,
        secureKYCUploadEnabled: false,
        transferEnabled: false,
        pushNotificationsEnabled: false
    )
}
