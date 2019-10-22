import Kitura
import KituraContracts
import LoggerAPI
import FileKit
import Foundation
import SwiftGD

let screenSize = Size(width: 1872, height: 1404)

func initializeFileRoutes(app: EtherFrame) {
    app.router.post("/images", middleware: BodyParser())
    app.router.post("/images") { request, response, next in
        Log.info("images res \(request) \(String(describing: request.body))")
        
        if let value = request.body {
            if case let .multipart(data) = value {
                for part in data {
                    try handleMultipart(image: part,
                                        response: response)
                }
            }
        }
    }
}

func handleMultipart(image part: Part,
                     response: RouterResponse) throws {
    Log.info("Part:\n\(part.filename), \(part.name), \(part.type), \(part.body)")
    
    let uploadURL = FileKit.executableFolderURL
        .appendingPathComponent("uploads", isDirectory: true)
        .appendingPathComponent(part.filename)
    let processedFilename = part.filename.appending(".bmp")
    let processedURL = FileKit.executableFolderURL
        .appendingPathComponent("processed", isDirectory: true)
        .appendingPathComponent(processedFilename)
    
    Log.info("File URL: \(uploadURL.absoluteString)")
    
    do {
        if case let .raw(data) = part.body {
            try data.write(to: uploadURL,
                           options: .atomic)
            let image = try Image(data: data)
            let processor = ImageProcessor(source: image, preferred: screenSize)
            processor.process()
            guard let processedImage = processor.output else {
                try response.send(status: .expectationFailed).end()
                return
            }
            let bmpData = try processedImage.export(as: .bmp(compression: false))
            try bmpData.write(to: processedURL,
                               options: .atomicWrite)
            try response.send(status: .created).end()
        }
    } catch {
        try response
            .send(status: .internalServerError)
            .end()
    }
}

extension EtherFrame {
    static func prepareFolders(names: [String]) throws {
        for name in names {
            let url = FileKit.executableFolderURL.appendingPathComponent(name, isDirectory: true)
            if FileManager.default.fileExists(atPath: url.path) {
                Log.info("\(name) directory exists")
                return
            }
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
            } catch {
                Log.error("Could not create \(name) directory")
                fatalError()
            }
        }
    }
}
