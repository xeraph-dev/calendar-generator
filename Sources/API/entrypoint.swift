import Vapor
import VercelVapor

@main
struct API: VaporHandler {
    static func configure(app: Application) async throws {
        app.get { _ in
            "Hello, Vapor"
        }
    }
}
