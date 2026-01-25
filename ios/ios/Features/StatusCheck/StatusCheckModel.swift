struct StatusCheckModel {
    let status: String
    let version: String

    init(status: String, version: String) {
        self.status = status
        self.version = version
    }
}
