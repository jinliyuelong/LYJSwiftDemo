//
//  ViewController.swift
//  QRCode
//
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.setupUi()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUi()  {
        self.view.backgroundColor = UIColor.white
        
                let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width-100) * 0.5, y: (UIScreen.main.bounds.size.height-30) * 0.5, width: 100, height: 30))
                button.setTitle("扫一扫", for: UIControlState())
                button.setTitleColor(UIColor.blue, for: UIControlState())
                button.addTarget(self, action: #selector(QRcodeViewController.buttonAction(_:)), for: UIControlEvents.touchUpInside)
                self.view.addSubview(button)
        
    }
    
    func buttonAction(_ sender : AnyObject){
        print("扫一扫")
        
        if self.cameraPermissions() {
        
        let  scanner = ScannerViewController()
        self.navigationController?.pushViewController(scanner, animated: true)
        }else{
        
            self.displayAlertControllerWithMessage("当前设备没有相机权限")
        }
        
        
    }
    
    
    
    /**
     判断相机权限
     
     - returns: 有权限返回true，没权限返回false
     */
    func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        debugPrint("当前的权限是=====\(authStatus.rawValue)")
        
        if(authStatus == AVAuthorizationStatus.authorized || authStatus == AVAuthorizationStatus.notDetermined) {
            return true
        }else {
            return false
        }
        
    }
    
    
    
    



}

