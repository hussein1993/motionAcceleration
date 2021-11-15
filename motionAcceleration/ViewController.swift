//
//  ViewController.swift
//  motionAcceleration
//
//  Created by Hussein Mahameed on 15/11/2021.
//

import UIKit
import CoreMotion

class tabBarViewController: UITabBarController {
    
    let motion = CMMotionManager()
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let monitorVc = MonitorViewController()
        let controlPanelVC = controlPanelViewController()
        let incidentsVC = incidentsViewController()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [monitorVc, controlPanelVC, incidentsVC]
        
        startAccelerometers()
    }
   

    func startAccelerometers() {
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 1
          self.motion.startAccelerometerUpdates()

          // Configure a timer to fetch the data.
           self.timer = Timer(fire: Date(), interval: 1,
                repeats: true, block: { (timer) in
             // Get the accelerometer data.
             if let data = self.motion.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
                
                let cords = ["X": x, "Y": y, "Z": z]
                NotificationCenter.default.post(name: .didReceiveData, object: self, userInfo: cords)
                
                 // print("x:\(x) , y:\(y) , z:\(z))")
             }
          })

          // Add the timer to the current run loop.
           RunLoop.current.add(self.timer!, forMode: .default)
       }
    }

}
extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}

