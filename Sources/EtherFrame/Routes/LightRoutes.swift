import KituraContracts
import LoggerAPI

func initializeLightRoutes(app: EtherFrame) {
    app.router.post("/lights", handler: app.postHandler)
}

extension EtherFrame {
    static var lights = [Light]()
    func postHandler(light: Light,
                     completion: (Light?, RequestError?) -> Void) {
        execute(async: {
            Log.debug("+++++\n+++++\n++++++\nPOST\n\(light.isActive)\n+++++\n+++++\n+++++\n")
            self.hardware.led(isActive: light.isActive)
        })
        execute {
            EtherFrame.lights.append(light)
        }
        completion(light, nil)
    }
}
