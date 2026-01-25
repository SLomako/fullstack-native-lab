import SwiftUI

struct StatusCheckView: View {
    @State private var statusText: String = "Tap the button to check status"
    @State private var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(statusText)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                Task {
                    await fetchStatus()
                }
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Check Status")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    @MainActor
    private func fetchStatus() async {
        isLoading = true
        statusText = "Loading..."

        do {
            let status = try await StatusCheckService().getStatus()
            statusText = "Status: \(status.status)\nVersion: \(status.version)"
        } catch {
            statusText = "Error loading status"
        }

        isLoading = false
    }
}
