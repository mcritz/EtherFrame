import KituraContracts

func initializeLightRoutes(app: EtherFrame) {
    app.router.post("/lights", handler: app.postHandler)
}

extension EtherFrame {
    static var lights = [Light]()
    func postHandler(light: Light,
                     completion: (Light?, RequestError?) -> Void) {
        execute {
            EtherFrame.lights.append(light)
        }
        completion(light, nil)
    }
}
