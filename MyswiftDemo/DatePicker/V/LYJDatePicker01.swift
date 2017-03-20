//
//  LYJDatePicker01.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/8.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class LYJDatePicker01: UIView {

    
    var canButtonReturnB: (() -> Void)? //取消按钮的回调
    
    var sucessReturnB: ((_ date:String) -> Void)?//选择的回调
    
    
    var title = UILabel.init(lableText: "选择时间")//标题
    
    var cancelButton = UIButton.init(title: "取消", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    var confirmButton = UIButton.init(title: "确定", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    
    
    
    
    var lineView = UIView()//一条横线
    
    
    var dateFormatter = DateFormatter()
    
    
    
    var datePicker = UIDatePicker()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        self.setupUI()
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        self.addtitle()
        
        self.addcancelButton()
        
        self.addlineView()
        
        self.addconfirmButton()
        
        self.addDatePicker()
        
    }
    
    
    
    
    //MARK:设置标题
    private func addtitle(){
        
        
        self.addSubview(title)
        
        self.titleP()
        self.titleF()
        
        
        
    }
    
    
    
    private func titleP(){
        title.textColor = TitlelableColor
        
        title.textAlignment = .center
        
        title.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
        
        
    }
    
    
    
    private func titleF(){
        title.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.centerX.equalTo(self.snp.centerX)
            
        }
        
    }
    
    
    
    private func titleD(title:String){
        
        self.title.text = title
    }
    
    
    //MARK:设置取消按钮
    private func addcancelButton(){
        
        self.addSubview(cancelButton)
        
        self.cancelP()
        
        self.cancelF()
    }
    
    private func cancelP(){
        
        self.cancelButton.setTitleColor(UIColor.system, for: .normal)
        self.cancelButton.tag = 101
        self.cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func cancelF(){
        
        self.cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.leading.equalTo(self.snp.leading).offset(mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(40)
            
        }
        
    }
    
    private func cancelD(){
        
    }
    
    
    
    //MARK:设置确定按钮
    private func addconfirmButton(){
        
        self.addSubview(confirmButton)
        
        self.confirmButtonP()
        
        self.confirmButtonF()
    }
    
    private func confirmButtonP(){
        
        self.confirmButton.setTitleColor(UIColor.system, for: .normal)
        self.confirmButton.tag = 102
        self.confirmButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func confirmButtonF(){
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.trailing.equalTo(self.snp.trailing).offset(-mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(40)
            
        }
        
    }
    
    
    
    
    //MARK:按钮的点击
    func buttonClick(_ sender:UIButton) {
        debugPrint("======取消按钮被点击=====")
        
        
        switch sender.tag {
        case 101:
            //取消
            if self.canButtonReturnB != nil {
                
                self.canButtonReturnB!()
            }
        case 102:
            //确定
            if self.sucessReturnB != nil {
                
                let currentDate = datePicker.date
                
                let dateStr = dateFormatter.string(from: currentDate)
                
                
                self.sucessReturnB!(dateStr)
            }
            
            
        default:
            break
        }
        
        
        
        
    }
    
    
    
    //MARK:设置横线
    private func addlineView(){
        
        self.addSubview(lineView)
        
        self.lineViewP()
        
        self.lineViewF()
        
    }
    
    private func lineViewP(){
        
        self.lineView.backgroundColor = UIColor.systemGray
        
        
    }
    
    private func lineViewF(){
        
        self.lineView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.cancelButton.snp.bottom).offset(mycommonEdge)
            
            make.leading.trailing.equalTo(self)
            
            make.height.equalTo(1)
            
            
        }
        
    }
    
    
    
    private func addDatePicker(){
        
        self.addSubview(datePicker)
        
        self.datePickerP()
        
        self.datePickerF()
        
    }
    
    private func datePickerP(){
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.datePickerMode = .date
        
        
        
    }
    
    private func datePickerF(){
        
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom)
            
            make.leading.trailing.bottom.equalTo(self)
            
        }
        
    }
    
    
    
    
    
    
    
    
}

