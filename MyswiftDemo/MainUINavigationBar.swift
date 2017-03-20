//
//  MainUINavigationBar.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class MainUINavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.barTintColor = UIColor.system
    }
    

}
