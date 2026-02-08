import XCTest

final class iosUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        // ВАЖНО: НИКАКОГО дефолта 127.0.0.1
        // Если переменная не задана — сразу валим тест с понятным текстом.
        guard let host = ProcessInfo.processInfo.environment["BACKEND_HOST"], !host.isEmpty else {
            XCTFail("BACKEND_HOST is not set. Set it in CI and in local scheme environment.")
            return
        }
        app.launchEnvironment["BACKEND_HOST"] = host
    }

    func testTapCheckStatusShowsCorrectLabel() throws {
        app.launch()

        let checkButton = app.buttons["Check Status"]
        XCTAssertTrue(checkButton.waitForExistence(timeout: 10))
        checkButton.tap()

        // Версию ставь ту, что реально отдаёт backend
        let statusText = app.staticTexts["Status: ok\nVersion: 0.0.1-SNAPSHOT"]
        XCTAssertTrue(statusText.waitForExistence(timeout: 20))
    }
}