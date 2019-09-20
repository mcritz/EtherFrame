import Foundation
import SwiftyGPIO

enum HardwareError: Error {
    case invalidGPIO
}

class Hardware {
    let gpios: [GPIOName: GPIO]
    let gp: GPIO
    var iteration = 0
    var isBlinking = false
    
    init() {
        self.gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi2)
        self.gp = gpios[.P2]!
        self.gp.direction = .OUT
    }
    
    func blinker(willBlink: Bool) {
        isBlinking = willBlink
        while (isBlinking) {
            iteration += 1
            print("iteration \(iteration)")
            gp.value = iteration % 2
            usleep(750000)
            gp.value = 0
            usleep(100000)
            gp.value = 1
            usleep(100000)
            gp.value = 0
            usleep(100000)
        }
    }
}
