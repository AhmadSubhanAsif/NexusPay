import XCTest
@testable import NexusPay

final class NexusPayTests: XCTestCase {
    func testTransferFeatureIsDisabledUntilProductionContractIsReady() {
        XCTAssertFalse(FeatureFlags.default.transferEnabled)
    }
}
