import Foundation

struct StatusCheckService {
    func getStatus() async throws -> StatusCheckModel {
        let url = URL(string: "http://192.168.64.24/health")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try StatusCheckParser.parse(data: data)
    }
}
