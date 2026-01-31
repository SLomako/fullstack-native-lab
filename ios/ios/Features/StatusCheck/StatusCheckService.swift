import Foundation

struct StatusCheckService {
    func getStatus() async throws -> StatusCheckModel {
        let url = URL(string: "http://127.0.0.1:8080/health")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try StatusCheckParser.parse(data: data)
    }
}
