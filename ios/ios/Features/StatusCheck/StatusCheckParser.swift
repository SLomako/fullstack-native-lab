import Foundation

struct StatusCheckParser {
    static func parse(data: Data) throws -> StatusCheckModel {
        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let status = json["status"] as? String,
            let version = json["version"] as? String
        else {
            throw ApiError.invalidData
        }

        return StatusCheckModel(status: status, version: version)
    }
}
