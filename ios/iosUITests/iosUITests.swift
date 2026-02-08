import XCTest

final class iosUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        let host = ProcessInfo.processInfo.environment["BACKEND_HOST"] ?? "127.0.0.1"
        app.launchArguments += ["-backendHost", host]
    }

    func testTapCheckStatusShowsCorrectLabel() {
        app.launch()

        let checkButton = app.buttons["Check Status"]
        XCTAssertTrue(checkButton.waitForExistence(timeout: 30))
        checkButton.tap()

        XCTAssertTrue(app.staticTexts["Status: ok\nVersion: 0.0.1-SNAPSHOT"].waitForExistence(timeout: 30))
    }
}