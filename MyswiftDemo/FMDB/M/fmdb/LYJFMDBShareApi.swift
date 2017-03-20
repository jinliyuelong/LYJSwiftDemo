//
//  LYJFMDBShareApi.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/9.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import Foundation

class LYJFMDBShareApi: NSObject {
    
    var database:FmormDatabase?
    
    var defaultDatabase:FmormDatabase {
    
        get{
            if database == nil {
                assertionFailure("请设置基础path")
            }
            
          
          
            return database!
        
        }
    
    }
    
    
    
   //单粒
    private static let lYJFMDBShareApi = LYJFMDBShareApi()
    class var shareApi:LYJFMDBShareApi {
        return lYJFMDBShareApi
    }
    
    
    
    func initDatabaseWithPath(path:String)  {
        
        database = FmormDatabase.init(path: path)
        
    }
    
    
    
}
