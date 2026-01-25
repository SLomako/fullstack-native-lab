import XCTest
@testable import ios

final class StatusCheckParserTests: XCTestCase {

    func testParseValidJSON() throws {
        let json = """
        {
            "status": "ok",
            "version": "1.2.3"
        }
        """.data(using: .utf8)!

        let result = try StatusCheckParser.parse(data: json)

        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.version, "1.2.3")
    }

    func testParseInvalidJSON() {
        let json = """
        {
            "something_else": "value"
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try StatusCheckParser.parse(data: json)) { error in
            XCTAssertEqual(error as? ApiError, .invalidData)
        }
    }
}
