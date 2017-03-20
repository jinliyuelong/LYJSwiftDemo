//
//  TestModel.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/13.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    
    
    var fmdbid: PrimaryKey?
    
    var id: Int = 0
    
    var id1: Float = 12.134
    
    
    var id2: Double = 0.0
    
    var name: String = "测试数据" //名称
    var event: NSNumber? //每日事件
    var sysmteCode: String? //说明
    
    var istrul:Bool = true
    
     var istrul1:Bool = false
    
//    var data:Data?
    
//    var date:Data?
    
    
    
   
    
    func buildSql()  {
        
      
        
        
        let tableInfo = TableInfo.getTableInfo(myclass: self.classForCoder)
        
        
        debugPrint("====_primaryFieldName===\(tableInfo._primaryFieldName)")
        
        
        
        
       
//        let sqlbuilder = SqlBuilder.buildQuerySql(myclass: self.classForCoder, columns: ["id","name"])
        
//        let sqlbuilder = SqlBuilder.buildCreatTableSql(myclass: self.classForCoder)
        
        
//        let sqlbuilder = SqlBuilder.buildInsertSql(entity: self)
        
        
        let sqlbuilder = SqlBuilder.buildUpdateSql(entity: self)
        
        debugPrint("====sqlbuilder==\(sqlbuilder.sql)")
        

    }
    
    
    
}
