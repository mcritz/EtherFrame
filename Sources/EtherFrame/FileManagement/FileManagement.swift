import Kitura
import KituraContracts
import LoggerAPI
import FileKit
import Foundation

func initializeFileRoutes(app: EtherFrame) {
    app.router.post("/images", middleware: BodyParser())
    app.router.post("/images") { request, response, next in
        Log.info("images res \(request) \(request.body)")
        if let value = request.body {
            if case let .multipart(data) = value {
                for part in data {
                    Log.info("Part:\n\(part.filename), \(part.name), \(part.body), \(part.type), \(part.body)")
                }
                let url = FileKit.executableFolderURL
                .appendingPathComponent("uploads", isDirectory: true)
                .appendingPathComponent(UUID().uuidString)
                Log.info("File URL: \(url.absoluteString)")
                try "data".write(to: url, atomically: true)
            }
        }
    }
}

extension EtherFrame {
}
