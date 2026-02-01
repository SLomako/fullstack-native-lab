import Foundation

struct StatusCheckService {
    func getStatus() async throws -> StatusCheckModel {
        let host = ProcessInfo.processInfo.environment["BACKEND_HOST"] ?? "127.0.0.1"
        let url = URL(string: "http://\(host):8080/health")!

        let (data, _) = try await URLSession.shared.data(from: url)
        return try StatusCheckParser.parse(data: data)
    }
}
