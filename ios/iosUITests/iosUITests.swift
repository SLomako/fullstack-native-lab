import XCTest

final class iosUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        let host = ProcessInfo.processInfo.environment["BACKEND_HOST"] ?? "127.0.0.1"
        app.launchEnvironment["BACKEND_HOST"] = host
    }

    func testTapCheckStatusShowsCorrectLabel() throws {

        // --- backend check (до запуска приложения) ---
        let host = ProcessInfo.processInfo.environment["BACKEND_HOST"] ?? "127.0.0.1"
        let url = URL(string: "http://\(host):8080/health")!
        XCTContext.runActivity(named: "DEBUG backend url") { activity in
            activity.add(XCTAttachment(string: url.absoluteString))
        }

        let exp = expectation(description: "Backend /health responds")

        var backendOk = false
        var debugText = ""

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { exp.fulfill() }

            if let error = error {
                debugText = "ERROR: \(error)"
                return
            }

            let status = (response as? HTTPURLResponse)?.statusCode ?? -1
            let body = String(data: data ?? Data(), encoding: .utf8) ?? "<non-utf8>"
            debugText = "HTTP \(status)\n\(body)"
            backendOk = (status == 200) && body.contains("\"status\":\"ok\"")
        }.resume()

        waitForExpectations(timeout: 10.0)
        XCTContext.runActivity(named: "DEBUG /health response") { activity in
            activity.add(XCTAttachment(string: debugText))
        }
        XCTAssertTrue(backendOk, "Backend is not reachable or returned unexpected response.\n\(debugText)")
        // --- end backend check ---

        app.launch()

        let checkButton = app.buttons["Check Status"]
        XCTAssertTrue(checkButton.waitForExistence(timeout: 10))
        checkButton.tap()

        let statusText = app.staticTexts["Status: ok\nVersion: 0.0.2-SNAPSHOT"]
        XCTAssertTrue(statusText.waitForExistence(timeout: 10))
    }
}
