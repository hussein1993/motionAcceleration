//
//  controlPanelViewController.swift
//  motionAcceleration
//
//  Created by Hussein Mahameed on 15/11/2021.
//

import Foundation
import UIKit
class controlPanelViewController : UIViewController{
    
    @objc func onDidReceiveData(_ notification: Notification) {
        
        if let data = notification.userInfo as? [String: Double] {
                for (axis, point) in data {
                    if axis == "X"{
                        if abs(point) > xCriticalVal  {
                           xStatus.image = xStatus.image?.withRenderingMode(.alwaysTemplate)
                           xStatus.tintColor = UIColor.red
                       }else{
                           xStatus.image = xStatus.image?.withRenderingMode(.alwaysTemplate)
                           xStatus.tintColor = UIColor.green
                       }
                    }
                    if axis == "Y"{
                        if abs(point) > yCriticalVal  {
                           yStatus.image = yStatus.image?.withRenderingMode(.alwaysTemplate)
                           yStatus.tintColor = UIColor.red
                       }else{
                           yStatus.image = yStatus.image?.withRenderingMode(.alwaysTemplate)
                           yStatus.tintColor = UIColor.green
                       }
                    }
                    if axis == "Z"{
                        if abs(point) > zCriticalVal  {
                           zStatus.image = zStatus.image?.withRenderingMode(.alwaysTemplate)
                           zStatus.tintColor = UIColor.red
                       }else{
                           zStatus.image = zStatus.image?.withRenderingMode(.alwaysTemplate)
                           zStatus.tintColor = UIColor.green
                       }
                    }
                    
                }
        }
        
       
    }
    
    @IBOutlet weak var xStatus: UIImageView!
    @IBOutlet weak var yStatus: UIImageView!
    @IBOutlet weak var zStatus: UIImageView!
    
    @IBOutlet weak var xStepper: UIStepper!
    @IBOutlet weak var yStepper: UIStepper!
    @IBOutlet weak var zStepper: UIStepper!
    
    @IBOutlet weak var xCritical: UILabel!
    @IBOutlet weak var yCritical: UILabel!
    
    @IBOutlet weak var zCritical: UILabel!
    
    var xCriticalVal : Double = 0.0
    var yCriticalVal : Double = 0.0
    var zCriticalVal : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        xStepper.value = 1
        xCritical.text = String(0.1)
        xCriticalVal = 0.1
        yStepper.value = 7
        yCritical.text = String(0.7)
        yCriticalVal = 0.7
        zStepper.value = 2
        zCritical.text = String(0.2)
        zCriticalVal = 0.2
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveData, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
     
    }
    @IBAction func xStepperClick(_ sender: Any) {
        if let val = (sender as? UIStepper)?.value {
            xCriticalVal = val/10
            xCritical.text = String(val/10)
        }
    
    }
    @IBAction func yStepper(_ sender: Any) {
        if let val = (sender as? UIStepper)?.value {
            yCriticalVal = val/10
            yCritical.text = String(val/10)
        }
    }
    
    @IBAction func zStepper(_ sender: Any) {
        if let val = (sender as? UIStepper)?.value {
            zCriticalVal = val/10
            zCritical.text = String(val/10)
        }
    }
    
}

