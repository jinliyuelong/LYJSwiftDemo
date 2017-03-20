//
//  BaseViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

extension  UIViewController {

    
    
    convenience init(title:String) {
        
        
        self.init()
        
        self.title = title
     
    }
    
    
    func displayAlertControllerWithMessage(_ message: String, closure: (() -> Void)? = nil) {
        displayAlertController(nil, message: message, actions: closure == nil ? nil : [UIAlertAction(title: "确定", style: .cancel, handler: { (action) in
            closure?()
        })])
    }
    
    func displayAlertControllerWithMessageAndTitle(_ title:String, message: String, closure: (() -> Void)? = nil) {
        displayAlertController(title, message: message, actions: closure == nil ? nil : [UIAlertAction(title: "确定", style: .cancel, handler: { (action) in
            closure?()
        })])
    }
    
    
    /**
     Display alert controler with given message and actions
     
     - Parameter message: the message to display
     - Parameter actions: the actiosn of alert controller
     */
    func displayAlertController(_ message: String, actions: [UIAlertAction]) {
        displayAlertController(nil, message: message, actions: actions)
    }
    
    /**
     Display alert controller with given title, message and actions
     
     - Parameter title:   the title of the alert controller
     - Parameter message: the message to display
     - Parameter actions: the actions of alert controller
     */
    func displayAlertController(_ title: String?, message: String?, actions: [UIAlertAction]?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            // Default cancel action
            alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        }
        present(alertController, animated: true, completion: nil)
    }

    
    
    
    
    

}
