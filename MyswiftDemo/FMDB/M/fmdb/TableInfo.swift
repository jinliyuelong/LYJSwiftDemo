//
//  TableInfo.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/9.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import Foundation

class TableInfo: NSObject {


    static var tableInfoMap:Dictionary<String, Any>?
    
    var _myclass:AnyClass?
    
    var _propertyMap:Dictionary<String, Any>?
    
    
    var _myTableName:String = ""
    
    
    var isTableExist:Bool = false
    
    var _primaryFieldName:String = ""
    
    
    
    
    init(myclass:AnyClass) {
        super.init()
        _myclass = myclass
        
        _propertyMap  = [String : Any]()
        
        isTableExist = false
        
        self.initTableInfo()
        
        
    }
    
    
    func initTableInfo()  {
        
        _myTableName = String.init(utf8String: class_getName(_myclass))!
        
      
        let range = _myTableName.range(of: ".")?.lowerBound
        
        
        
        
        
        

       _myTableName = _myTableName.substring(from: _myTableName.index(after: range!) )
        
        
        debugPrint("tablename 是 \(_myTableName)")
        
//        _myTableName = "TestModel"
        
        self.buildProperty()
        
    }
    
    func buildProperty()  {
        var count: UInt32 = 0
        
        let properties = class_copyPropertyList(_myclass, &count)
        
        
        // Swift中类型是严格检查的，必须转换成同一类型
        for i in 0 ..< Int(count) {
            // UnsafeMutablePointer<objc_property_t>是
            // 可变指针，因此properties就是类似数组一样，可以
            // 通过下标获取
            let property = properties?[i]
            
            let propertyName = String.init(cString: property_getName(property), encoding: .utf8)
            
            let attributeName = String.init(cString: property_getAttributes(property), encoding: .utf8)
            
            
            if (attributeName?.contains("PrimaryKey"))! {
                 _primaryFieldName = propertyName!
            }
            
         
            
            debugPrint("proertyName = \(String(describing: propertyName)),attname = \(String(describing: attributeName))")
            
            _propertyMap?[propertyName!] = attributeName
            
        }
        
        // 不要忘记释放内存，否则C语言的指针很容易成野指针的
        free(properties)

        
    }
    
    
   
  class  func getTableInfo(myclass:AnyClass) -> TableInfo {
    
  
    

    
    let className = String.init(utf8String: class_getName(myclass))!
    
    
    if(tableInfoMap == nil){
        
        tableInfoMap = Dictionary<String, Any>()
        
    }
    
    if tableInfoMap?[className] != nil {
        return tableInfoMap![className] as! TableInfo
    }
    
    let tableInfo:TableInfo = TableInfo.init(myclass: myclass)
    
    
    
    tableInfoMap?[className] = tableInfo
    
    
    
    return tableInfo
    
    
    
    }

}
