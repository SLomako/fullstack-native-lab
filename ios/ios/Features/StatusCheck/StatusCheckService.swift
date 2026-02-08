import Foundation

struct StatusCheckService {

    private func backendHost() -> String {
        let args = ProcessInfo.processInfo.arguments
        if let i = args.firstIndex(of: "-backendHost"), i + 1 < args.count {
            return args[i + 1]
        }
        return "127.0.0.1"
    }

    func getStatus() async throws -> StatusCheckModel {
        let host = backendHost()
        let url = URL(string: "http://\(host):8080/health")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try StatusCheckParser.parse(data: data)
    }
}