import KituraContracts

func initializeLightRoutes(app: EtherFrame) {
    app.router.post("/lights", handler: app.postHandler)
}

extension EtherFrame {
    static var lights = [Light]()
    func postHandler(light: Light,
                     completion: (Light?, RequestError?) -> Void) {
        execute(async: {
            print("+++++\n+++++\n++++++\nBlink\n+++++\n+++++\n+++++\n")
            self.hardware.led(isActive: light.isActive)
        })
        execute {
            EtherFrame.lights.append(light)
        }
        completion(light, nil)
    }
}
