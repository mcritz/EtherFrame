import Kitura
import Dispatch

public class EtherFrame {

    let router = Router()
    let workerQueue = DispatchQueue(label: "worker")
    var workItem = DispatchWorkItem(block: {
        print("init")
    })
    let hardware: Hardware

    public init() throws {
        hardware = Hardware()
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
    
    func execute(async block: @escaping (() -> Void)) {
        workItem.cancel()
        workItem = DispatchWorkItem(qos: .default, flags: [], block: block)
        workerQueue.async(execute: workItem)
    }
    
}
