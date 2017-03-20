//
//  HeaderViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/27.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {

    
     var headerTabView:HeaderTabView?
    
     let itemTitles = ["空间巡检","设备巡检","保养123","维修123"]
    
    var tagtoTap:Int = 0//跳转到哪个页签

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func initUI() {
        
        self.view.backgroundColor = UIColor.white
        
    
        
        
        
        let frame = CGRect(x: 0, y: 60, width: screenWidth, height: 38)
//        
        self.headerTabView = HeaderTabView(frame: frame, itemTitles:itemTitles)
        
        
        self.headerTabView!.delegate = self
        
       
        
        self.view.addSubview(self.headerTabView!)
        
        
        let button = UIButton()
        
        button.tag = self.tagtoTap
        
        self.headerTabView?.tapButton(button)
      
        
    }

   
}


extension HeaderViewController: TapItemDelegate {
    func tapItem(index: Int) {
        
        
    }
}
