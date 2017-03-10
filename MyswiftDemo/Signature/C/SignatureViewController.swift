//
//  SignatureViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/7.
//  Copyright © 2017年 hand. All rights reserved.
//

import UIKit


class SignatureViewController: UIViewController {


     var cancelButton = UIButton.init(title: "取消", bgColor: UIColor.system, font:  CGFloat(mylableSize)) //取消按钮
    
    
    
    var saveButton = UIButton.init(title: "保存", bgColor: UIColor.system, font:  CGFloat(mylableSize)) //取消按钮
    
    
    var clearButton = UIButton.init(title: "清空", bgColor: UIColor.system, font:  CGFloat(mylableSize)) //取消按钮
    
   	

    lazy  var drawSignatureView: DrawSignatureView = {
    
        let uiview = DrawSignatureView()
        return uiview
    }()
    
    
    lazy var  image: UIImage = {
    
        let image = UIImage()
        
        return image
    }()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.loadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK:设置ui
    func setupUI()  {
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(saveButton)
        
        self.view.addSubview(clearButton)
        
        self.view.addSubview(cancelButton)
        
        self.adddrawSignatureView()
        
        self.addsaveButton()
        
        self.addclearButton()
        
        self.addcancelButton()
    }
    
    
    //MARK:设置签名view
    
    func adddrawSignatureView()  {
        
        self.view.addSubview(drawSignatureView)
        
        self.setdrawSignatureViewF()
        
        self.setSaveButtonP()
        
    }
    
    func setdrawSignatureViewP() {
        
    }
    
    func setdrawSignatureViewF() {
        
        drawSignatureView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-42)
        }
    }
    
    //MARK:设置保存按钮
    func addsaveButton()  {
        
        
        
        self.setSaveButtonP()
        
        self.setSaveButtonF()
        
    }
    
    func setSaveButtonP() {
        
        saveButton.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 2
        
        saveButton.addTarget(self, action: #selector(savebuttonClick(sender:)), for: .touchUpInside)
    }
    
    
    func setSaveButtonF() {
        
        saveButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(self.view)
            
            make.height.equalTo(40)
            
            make.trailing.equalTo(clearButton.snp.leading).offset(-1)
            
        }
        
        
    }
    
    
    
    
    //MARK:设置清空按钮
    func addclearButton()  {
        
      
        
        self.setclearButtonP()
        
        self.setclearButtonF()
        
    }
    
    func setclearButtonP() {
        clearButton.layer.masksToBounds = true
        
        clearButton.layer.cornerRadius = 2
        
        clearButton.addTarget(self, action: #selector(clearButtonclick(sender:)), for: .touchUpInside)
    }
    
    
    func setclearButtonF() {
        
        clearButton.snp.makeConstraints { (make) in
           
            make.width.height.bottom.equalTo(saveButton)
            
            make.leading.equalTo(saveButton.snp.trailing).offset(1)
            
            make.trailing.equalTo(cancelButton.snp.leading).offset(-1)

            
        }
        
        
        
        
        
    }
    
    
    
    //MARK:设置取消按钮
    func addcancelButton()  {
        
       
        
        self.setcancelButtonP()
        
        self.setcancelButtonF()
        
    }
    
    func setcancelButtonP() {
        cancelButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 2
        
         cancelButton.addTarget(self, action: #selector(cancelButtonClick(sender:)), for: .touchUpInside)
    }
    
    
    func setcancelButtonF() {
        
        cancelButton.snp.makeConstraints { (make) in
            
            make.width.height.bottom.equalTo(saveButton)
            
            make.leading.equalTo(clearButton.snp.trailing).offset(1)
            
            make.trailing.equalTo(self.view.snp.trailing)
            
            
        }
        
        
        
        
        
    }
    
    
    //MARK:保存按钮点击
    func savebuttonClick(sender:UIButton)  {
        let signatureImage = self.drawSignatureView.getSignature()
        
        self.image = signatureImage
        
        
    }
    
    //MARK:清空按钮
    
    func clearButtonclick(sender:UIButton)  {
        self.drawSignatureView.clearSignature()
    }
    
    
    
    //MARK: 取消按钮
    
    func cancelButtonClick(sender:UIButton)  {
        
       //清空签名
        
        self.drawSignatureView.clearSignature()
        
        self.navigationController!.popViewController(animated: true)
        
    }
    
    
    //MARK:获取数据
    func loadData()  {
        
    }
    
    
    

}
