//
//  ScannerBackgroundView.swift
//  BDHome
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class ScannerBackgroundView: UIView {
    
    
    var scanResult = UITextField()
    
    var scanResultPlaceHolder:String = ""
    
    
    
    
    //屏幕扫描区域视图
    let barcodeView = UIView(frame: CGRect(x: screenWidth  * 0.2, y:  screenHeight * 0.15, width: screenWidth  * 0.6, height: screenWidth  * 0.6))
    //扫描线
    let scanLine = UIImageView()
    
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    func stopScan()  {
        timer.invalidate()
    }
    
    
    
    init(frame: CGRect, scanResultPlaceHolder:String) {
        
        super.init(frame: frame)
        
        self.scanResultPlaceHolder = scanResultPlaceHolder
        
        self.setupUi()
    }
    
    
    func setupUi()  {
        barcodeView.layer.borderWidth = 1.0
        barcodeView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(barcodeView)
        
        //设置扫描线
        scanLine.frame = CGRect(x: 0, y: 0, width: barcodeView.frame.size.width, height: 5)
        scanLine.image = UIImage(named: "QRCodeScanLine")
        
        //添加扫描线图层
        barcodeView.addSubview(scanLine)
        
        self.createBackGroundView()
        
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveScannerLayer(_:)), userInfo: nil, repeats: true)
        
        
    }
    
    
    func  createBackGroundView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0,  width: screenWidth , height:  screenHeight * 0.15))
        let bottomView = UIView(frame: CGRect(x: 0, y: screenWidth  * 0.6 +  screenHeight * 0.15, width: screenWidth , height:  screenHeight * 0.85 - screenWidth * 0.6))
        
        let leftView = UIView(frame: CGRect(x: 0, y:  screenHeight * 0.15, width: screenWidth  * 0.2, height: screenWidth  * 0.6))
        let rightView = UIView(frame: CGRect(x: screenWidth  * 0.8, y:  screenHeight * 0.15, width: screenWidth  * 0.2, height: screenWidth  * 0.6))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: screenWidth , height: 21))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "将二维码/条形码放入扫描框内，即自动扫描"
        
        bottomView.addSubview(label)
        
        bottomView.addSubview(scanResult)
        
        
        self.addscanResult()
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
        
        
        
    }
    
    
    func addscanResult()  {
        
        self.scanResultP()
        self.scanResultF()
    }
    
    
    //设置reslut
    func scanResultP()  {
        
        scanResult.textAlignment = .left
        
        scanResult.textColor = UIColor.white
        
        scanResult.layer.masksToBounds = true
        
        scanResult.layer.borderColor = mygrayColor.cgColor
        
        scanResult.layer.borderWidth = 1
        
        scanResult.leftViewMode = .always
        
        
        scanResult.attributedPlaceholder = NSAttributedString(string: self.scanResultPlaceHolder, attributes: [NSForegroundColorAttributeName:UIColor.white ])
        
        scanResult.layer.cornerRadius = 3
        
        scanResult.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
        
    }
    
    func scanResultF()  {
        
        scanResult.frame = CGRect.init(x: screenWidth * 0.1, y: 10 + screenHeight * 0.1, width: screenWidth * 0.8, height: 40)
        
    }
    
    
    
    func scanResultD(reslut:String){
        
        scanResult.text = " " + reslut
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //让扫描线滚动
    func moveScannerLayer(_ timer : Timer) {
        scanLine.frame = CGRect(x: 0, y: 0, width: self.barcodeView.frame.size.width, height: 12);
        UIView.animate(withDuration: 2) {
            self.scanLine.frame = CGRect(x: self.scanLine.frame.origin.x, y: self.scanLine.frame.origin.y + self.barcodeView.frame.size.height - 10, width: self.scanLine.frame.size.width, height: self.scanLine.frame.size.height);
            
        }
        
    }
}
