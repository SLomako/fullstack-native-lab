import XCTest

final class iosUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        guard let host = ProcessInfo.processInfo.environment["BACKEND_HOST"], !host.isEmpty else {
            XCTFail("BACKEND_HOST is not set. Provide it from CI or local scheme env.")
            return
        }

        app.launchEnvironment["BACKEND_HOST"] = host
    }

    func testTapCheckStatusShowsCorrectLabel() throws {
        app.launch()

        let checkButton = app.buttons["Check Status"]
        XCTAssertTrue(checkButton.waitForExistence(timeout: 5))
        checkButton.tap()

        let statusText = app.staticTexts["Status: ok\nVersion: 0.0.1-SNAPSHOT"]
        XCTAssertTrue(statusText.waitForExistence(timeout: 10))
    }
}