import XCTest

final class iosUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        let host = ProcessInfo.processInfo.environment["BACKEND_HOST"] ?? "127.0.0.1"
        app.launchEnvironment["BACKEND_HOST"] = host
    }

    @MainActor
    func testTapCheckStatusShowsCorrectLabel() {
        app.launch()

        let checkButton = app.buttons["Check Status"]
        XCTAssertTrue(checkButton.waitForExistence(timeout: 10), "The 'Check Status' button was not found")
        checkButton.tap()

        let statusText = app.staticTexts["Status: ok\nVersion: 0.0.2-SNAPSHOT"]
        XCTAssertTrue(statusText.waitForExistence(timeout: 10), "Expected status text was not found")
    }
}