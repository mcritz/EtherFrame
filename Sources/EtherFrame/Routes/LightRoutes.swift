import KituraContracts

func initializeLightRoutes(app: EtherFrame) {
    app.router.post("/lights", handler: app.postHandler)
}

extension EtherFrame {
    static var lights = [Light]()
    static var hardware = Hardware()
    func postHandler(light: Light,
                     completion: (Light?, RequestError?) -> Void) {
        execute {
            EtherFrame.lights.append(light)
            EtherFrame.hardware.blinker(willBlink: light.isActive)
        }
        completion(light, nil)
    }
}
