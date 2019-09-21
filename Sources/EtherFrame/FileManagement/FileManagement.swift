import Kitura
import KituraContracts
import LoggerAPI
import FileKit
import Foundation

func initializeFileRoutes(app: EtherFrame) {
    app.router.post("/images", middleware: BodyParser())
    app.router.post("/images") { request, response, _ in
        Log.info("images res \(request) \(request.body)")
        if let value = request.body {
            if case let .multipart(data) = value {
                for part in data {
                    Log.info("Part:\n\(part.filename), \(part.name), \(part.type), \(part.body)")
                    let url = FileKit.executableFolderURL
                        .appendingPathComponent("uploads", isDirectory: true)
                        .appendingPathComponent(part.filename)
                    Log.info("File URL: \(url.absoluteString)")
                    if case let .raw(data) = part.body {
                        try data.write(to: url)
                    }
                }
            }
        }
    }
}

extension EtherFrame {
}
