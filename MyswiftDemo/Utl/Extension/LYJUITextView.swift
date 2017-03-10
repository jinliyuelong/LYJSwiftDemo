//
//  LYJUITextView.swift
//  Colliers-CFIM
//
//  Created by Liyanjun on 2017/1/17.
//  Copyright © 2017年 yingwf. All rights reserved.
//

import UIKit


//实现垂直居中 和placeholder
class LYJUITextView: UITextView {
    
    //实现placeholder
    var myPlaceholder = String()//
    
    var myPlaceholderColor = UIColor()//
    
    var myplaceholderLabel = UILabel()
    
    //end 实现placeholder
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    
    
    
    func setupUI() {
        self.addkvo()
        self.addplaceHolder()
        
        self.addNoti()
    }
    
    func addplaceHolder()  {
        
        
        
        
        self.myplaceholderLabel.textColor = UIColor.lightGray
        
        
        
        self.myplaceholderLabel.lineBreakMode = .byWordWrapping
        self.myplaceholderLabel.numberOfLines = 0
        self.myplaceholderLabel.font = self.font
        self.myplaceholderLabel.backgroundColor = UIColor.clear
        
        self.addSubview(self.myplaceholderLabel)
        
        
        
        
        self.myplaceholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(0)
            make.leading.equalTo(self.snp.leading).offset(0)
            
        }
        
        
        
        
        
        
    }
    
    
    func addkvo()  {
        //添加seize坚挺
        self.addkvoforsize()
        
        
        
    }
    
    //添加通知
    func addNoti()  {
        //            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        NotificationCenter.default.addObserver(self, selector:#selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
    }
    
    
    
    
    
    func textDidChange() {
        self.myplaceholderLabel.isHidden = self.hasText
    }
    
    
    
    func addkvoforsize()  {
        
        
        
        self.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    
    func removekvo()  {
        self.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        if keyPath == "contentSize" {
            
            let tv:UITextView = object as! UITextView
            
            let  deadSpace = tv.bounds.size.height - tv.contentSize.height
            
            
            let inset:CGFloat = max(0, deadSpace/2)
            
            tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right)
            
            
            
            
            
            
        }
        
    }
    
    
    deinit {
        self.removekvo()
    }
    
    
}





