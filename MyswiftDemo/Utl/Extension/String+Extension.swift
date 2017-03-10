//
//  String+Extension.swift
//  Colliers-CFIM
//
//  Created by  ywf on 16/12/19.
//  Copyright © 2016年 yingwf. All rights reserved.
//

import Foundation


extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    func getDateByFormatString(_ str: String) -> Date? {
        
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = str
        dateFormat.locale = Locale.current
        
        return dateFormat.date(from: self)
    }
    
    
    //截取字符串
    func substrfromBegin(length:Int)->String{
        
        let index = self.index(self.startIndex, offsetBy: length)
        
        return self.substring(to: index)
        
    }
    
    
    func getCommonDateByFormatString() -> Date? {
        return getDateByFormatString("yyyy-MM-dd HH:mm:ss")
    }
    
    
   
    
    
    
    
    
}
