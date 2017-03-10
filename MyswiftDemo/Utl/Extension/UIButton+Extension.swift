//
//  UIButton+Extension.swift
//  Colliers-CFIM
//
//  Created by Liyanjun on 2017/1/13.
//  Copyright © 2017年 yingwf. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func createBtn (title : String , bgColor : UIColor , font : CGFloat) -> UIButton {
        
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        
        return btn
    }
    
    convenience init(title : String , bgColor : UIColor , font : CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
}
