import XCTest

final class NexusPayUITests: XCTestCase {
    func testLaunches() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["NexusPay"].exists)
    }
}
