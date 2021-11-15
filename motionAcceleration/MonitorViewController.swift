//
//  MonitorViewController.swift
//  motionAcceleration
//
//  Created by Hussein Mahameed on 15/11/2021.
//

import Foundation
import UIKit

class MonitorViewController : UIViewController{
  
    @IBOutlet weak var xStatus: UIImageView!
    
    @IBOutlet weak var zStatus: UIImageView!
    @IBOutlet weak var yStatus: UIImageView!
    var definedX:Double = 0.0
    var definedY:Double = 0.0
    var definedZ:Double = 0.0
    

    @IBOutlet weak var xValue: UILabel!
    
    @IBOutlet weak var zOverFlow: UILabel!
    @IBOutlet weak var zValue: UILabel!
    @IBOutlet weak var yOverFlow: UILabel!
    @IBOutlet weak var yValue: UILabel!
    @IBOutlet weak var xOverFlow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveData, object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        
        guard let controlTab = self.tabBarController?.viewControllers?[1] as? controlPanelViewController else { return }
        
        definedX = controlTab.xCriticalVal
        definedY = controlTab.yCriticalVal
        definedZ = controlTab.zCriticalVal
        
        if let data = notification.userInfo as? [String: Double] {
                for (axis, point) in data {
                    if axis == "X"{
                        xValue.text = String(format : "%.2f",abs(point))
                        if abs(point) > definedX  && definedX > 0 {
                           xStatus.image = xStatus.image?.withRenderingMode(.alwaysTemplate)
                           xStatus.tintColor = UIColor.red
                            xOverFlow.text = String(format: "%.2f", abs(point)-definedX)
                       }else{
                           xStatus.image = xStatus.image?.withRenderingMode(.alwaysTemplate)
                           xStatus.tintColor = UIColor.green
                           xOverFlow.text = "-"
                       }
                    }
                    if axis == "Y"{
                        yValue.text = String(format : "%.2f",abs(point))
                        if abs(point) > definedY && definedY > 0{
                           yStatus.image = yStatus.image?.withRenderingMode(.alwaysTemplate)
                           yStatus.tintColor = UIColor.red
                            yOverFlow.text = String(format: "%.2f", abs(point)-definedY)
                       }else{
                           yStatus.image = yStatus.image?.withRenderingMode(.alwaysTemplate)
                           yStatus.tintColor = UIColor.green
                           yOverFlow.text = "-"
                       }
                    }
                    if axis == "Z"{
                        zValue.text = String(format : "%.2f",abs(point))
                        if abs(point) > definedZ  && definedZ > 0 {
                           zStatus.image = zStatus.image?.withRenderingMode(.alwaysTemplate)
                           zStatus.tintColor = UIColor.red
                           zOverFlow.text = String(format: "%.2f", abs(point)-definedZ)
                       }else{
                           zStatus.image = zStatus.image?.withRenderingMode(.alwaysTemplate)
                           zStatus.tintColor = UIColor.green
                           zOverFlow.text = "-"
                       }
                    }
                    
                }
        }
        
       
    }
}
