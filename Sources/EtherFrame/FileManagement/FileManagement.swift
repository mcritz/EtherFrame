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
                    Log.info("Part:\n\(part.filename), \(part.name), \(part.type), \(part.body)")
                    
                    let url = FileKit.executableFolderURL
                        .appendingPathComponent("uploads", isDirectory: true)
                        .appendingPathComponent(part.filename)
                    
                    Log.info("File URL: \(url.absoluteString)")
                    
                    do {
                        if case let .raw(data) = part.body {
                            try data.write(to: url,
                                           options: .atomic)
                            try response.send(status: .created).end()
                        }
                    } catch {
                        try response
                            .send(status: .internalServerError)
                            .end()
                    }
                }
            }
        }
    }
}

extension EtherFrame {
    static func prepareFolders() throws {
        let uploadURL = FileKit.executableFolderURL.appendingPathComponent("uploads", isDirectory: true)
        if FileManager.default.fileExists(atPath: uploadURL.absoluteString) {
            Log.info("uploads directory exists")
            return
        }
        do {
            try FileManager.default.createDirectory(atPath: uploadURL.absoluteString,
                                            withIntermediateDirectories: true,
                                            attributes: [.posixPermissions : "400"])
        } catch {
            Log.error("Could not create uploads directory")
            fatalError()
        }
    }
}
