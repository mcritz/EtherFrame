import Kitura
import Dispatch

public class EtherFrame {

    let router = Router()
    let workerQueue = DispatchQueue(label: "worker")

    public init() throws {

    }

    func postInit() throws {
        initializeLightRoutes(app: self)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
    
    func execute(_ block: (() -> Void)) {
        workerQueue.sync {
            block()
        }
    }
}
