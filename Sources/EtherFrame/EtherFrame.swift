import Kitura
import Dispatch
import LoggerAPI

public class EtherFrame {

    let router = Router()
    let workerQueue = DispatchQueue(label: "worker")
    var workItem = DispatchWorkItem(block: {
        print("workItem")
    })

    public init() throws {
    }

    func postInit() throws {
        try EtherFrame.prepareFolders(names: ["uploads", "processed"])
        initializeFileRoutes(app: self)
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
    
    func execute(async block: @escaping (() -> Void)) {
        Log.debug("execute async")
        workItem.cancel()
        workItem = DispatchWorkItem(qos: .default, flags: [], block: block)
        workerQueue.async(execute: workItem)
    }
    
}
