//
//  FmormDatabase.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/9.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import Foundation
import FMDB

class FmormDatabase: NSObject {
    
    
    private var _debugMode = false
    
    var lastError:Error?
    
    
    
    var databasequeqe: FMDatabaseQueue?//队列 实现事物的的查询
    
    private  var databasepool:FMDatabasePool?//连接池
    
    init(path:String , debugger:Bool ) {
        
        super.init()
        _debugMode = debugger
        
        databasepool = FMDatabasePool.init(path: path)
        
        databasequeqe = FMDatabaseQueue.init(path: path)
        
        databasepool?.maximumNumberOfDatabasesToCreate = 3 //最大连接数
        
        if debugger {
            
            debugPrint("database path is \(path)")
        }
        
    }
    
    
    
    convenience init(path:String) {
        
        self.init(path:path ,debugger:true)
        
    }
    //MARK:设置最大连接数
    func setmaxNumberdatabase(num:Int)  {
        databasepool?.maximumNumberOfDatabasesToCreate = UInt(num)
    }
    
    
    func gettablename(myclass:AnyClass) -> String {
        var tableName = String.init(cString: class_getName(myclass), encoding: .utf8)
        
        
        
        let range = tableName?.range(of: ".")?.lowerBound
        
        
        
        
        
        
        
        tableName = tableName?.substring(from: (tableName?.index(after: range!))! )
        
        
        return tableName!
        
    }
    
    
    //MARK:drop
    func dropTable(myclass:AnyClass) ->Bool {
        let tableName = self.gettablename(myclass: myclass)
        
        
        let dropSql = "DROP TABLE \(tableName)"
        
        
        return self.excute(sql: dropSql, param: nil)
        
        
    }
    
    
    
    //MARK:查询
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - myclass: 类名
    ///   - others: 其他的查询入 max,min [max(id),min(id)]
    ///   - strWhere: <#strWhere description#>
    ///   - strOrderby: <#strOrderby description#>
    /// - Returns: <#return value description#>
    func query(myclass:AnyClass,others:Array<String>,strWhere:String?,strOrderby:String?) ->Array<Any>? {
        var resultArray = Array<Any>()
        
        let tableName = self.gettablename(myclass: myclass)
        
        var querySql = "SELECT \(others) FROM \(tableName)"
        
        self.checkTableExists(myclass: myclass)
        
        
        
        if let strWhere = strWhere {
            querySql.append(" WHERE \(strWhere) ")
            
        }
        
        if let strOrderby = strOrderby {
            
            querySql.append(" ORDER BY \(strOrderby)")
        }
        
        if self._debugMode {
            debugPrint("查询sql 是 \(querySql)")
        }
        
        let set = self.query(sql: querySql, values: [])
        
        let propertys = TableInfo.init(myclass: myclass)._propertyMap
        
        
        while set.next() {
            
            let result = set.resultDictionary()
            
            
            
            let obj:AnyObject = myclass.alloc() as! NSObject
            
            
            for (key,value) in result! {
                
                //String 类型 复制 nil为闪退
                if !(value as AnyObject).isEqual(NSNull.init()) {
                    obj.setValue(value, forKey: key as! String)
                    
                }else{
                    
                    
                    let provalue =  propertys?[key as! String] as! String
                    
                    if provalue.contains("NSString") {
                        obj.setValue("", forKey: key as! String)
                        
                    }else{
                        
                        obj.setValue(value, forKey: key as! String)
                    }
                    
                    
                    
                }
                
            }
            
            
            resultArray.append(obj)
            
        }
        
        
        
        
        
        
        
        return resultArray
    }
    
    
    
    func query(myclass:AnyClass,columns:Array<String>?,strWhere:String?,strOrderby:String?) ->Array<Any>? {
        
        var resultArray = Array<Any>()
        
        var querySql = SqlBuilder.buildQuerySql(myclass: myclass, columns: columns)
        
        self.checkTableExists(myclass: myclass)
        
        
        
        if let strWhere = strWhere {
            querySql.append(" WHERE \(strWhere) ")
            
        }
        
        if let strOrderby = strOrderby {
            
            querySql.append(" ORDER BY \(strOrderby)")
        }
        
        if self._debugMode {
            debugPrint("查询sql 是 \(querySql)")
        }
        
        let set = self.query(sql: querySql, values: [])
        
        
        let propertys = TableInfo.init(myclass: myclass)._propertyMap
        
        
        while set.next() {
            
            let result = set.resultDictionary()
            
            
            
            let obj:AnyObject = myclass.alloc() as! NSObject
            
            
            for (key,value) in result! {
                
                //String 类型 复制 nil为闪退
                if !(value as AnyObject).isEqual(NSNull.init()) {
                    obj.setValue(value, forKey: key as! String)
                    
                }else{
                    
                    
                    let provalue =  propertys?[key as! String] as! String
                    
                    if provalue.contains("NSString") {
                        obj.setValue("", forKey: key as! String)
                        
                    }else{
                        
                        obj.setValue(value, forKey: key as! String)
                    }
                    
                    
                    
                }
                
                
                
                
                
            }
            
            
            resultArray.append(obj)
            
        }
        
        
        
        
        
        
        
        return resultArray
        
    }
    //MARK:删除
    
    
    func delete(myclass:AnyClass)  -> Bool  {
        
        return self.delete(myclass: myclass, strWhere: nil)
    }
    
    
    func delete(myclass:AnyClass,strWhere:String?) -> Bool {
        var result = false
        
        self.checkTableExists(myclass: myclass)
        
        
        var deleteSql = SqlBuilder.buildDeleteSql(myclass: myclass)
        
        if let strWhere = strWhere {
            deleteSql.append(" WHERE \(strWhere)")
        }
        
        
        
        
        
        if _debugMode {
            debugPrint("deleteSql is ======= \(deleteSql)")
        }
        
        
        
        result = self.excute(sql: deleteSql, param: nil)
        
        return result
        
        
    }
    
    
    //MARK:更改
    
    func update(entity:AnyObject) -> Bool {
        return self.update(entity: entity, strWhere: nil)
    }
    
    
    func update(entity:AnyObject,strWhere:String?) -> Bool {
        var result = false
        
        
        self.checkTableExists(myclass: object_getClass(entity))
        
        let info = SqlBuilder.buildUpdateSql(entity: entity)
        
        
        var updateSql = info.sql
        
        
        if let strWhere = strWhere {
            updateSql?.append(" WHERE \(strWhere)")
        }
        
        
        
        
        
        if _debugMode {
            debugPrint("updateSql is ======= \(updateSql)")
        }
        
        //        result = self.excute(sql: updateSql!, param: info.arguments)
        
        result = self.excute(sql: updateSql!, param: nil)
        
        return result
        
    }
    
    //MARK:穿件索引
    
    func createIndex(entity:AnyObject,columns:Array<String>) -> Bool {
        var result = false
        
        
        self.checkTableExists(myclass: object_getClass(entity))
        
        
        
        let indexSql = SqlBuilder.buildcreateIndexSql(myclass: entity.classForCoder, columns: columns)
        
        
        
        
        if _debugMode {
            debugPrint("indexSql is ======= \(indexSql)")
        }
        
        //        result = self.excute(sql: updateSql!, param: info.arguments)
        
        result = self.excute(sql: indexSql, param: nil)
        
        return result
        
    }
    
    
    //MARK:插入
    func save(entity:AnyObject) -> Bool {
        
        var result = false
        
        
        
        
        self.checkTableExists(myclass: object_getClass(entity))
        
        let info = SqlBuilder.buildInsertSql(entity: entity)
        
        
        let tableInfo = info.tableInfo
        
        
        
        
        
        if _debugMode {
            debugPrint("saveSql is ======= \(info.sql)")
        }
        
        //       result = self.excute(sql: info.sql!, param: info.arguments)
        
        result = self.excute(sql: info.sql!, param: nil)
        
        
        if result && tableInfo?._primaryFieldName != nil {
            let lastId = self.getLastInsertRowid(tableName: (tableInfo?._myTableName)!)
            
            
            entity.setValue(lastId, forKey: (tableInfo?._primaryFieldName)!)
            
        }
        
        
        return result
        
    }
    
    
    /**
     *  获取刚插入的主键id，如果返回－1则是没有
     *
     *  @param tableName
     */
    
    func getLastInsertRowid(tableName:String) -> Int {
        
        let querySql = "select last_insert_rowid() lastId from \(tableName)"
        
        let reultset = self.query(sql: querySql, values: [])
        
        var lastId = -1
        
        if reultset.next() {
            
            lastId = Int(reultset.int(forColumn: "lastId"))
            
            reultset.close()
            
        }
        
        return lastId
        
        
    }
    
    
    //涉及到事务操作的多个
    
    
    //MARK:判断是否存在，否则自动创建
    
    func checkTableExists(myclass:AnyClass) ->Bool {
        
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        if !self.isTableExist(tableInfo: tableInfo) {
            let result =  self.excute(sql: SqlBuilder.buildCreatTableSql(myclass: myclass), param: nil)
            
            
            return result
            debugPrint("查询结果\(result)")
        }
        
        
        return true
        
        
    }
    
    //MARK:判断是否存在
    func checkTableExistsNotCreate(myclass:AnyClass) ->Bool {
        
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        return self.isTableExist(tableInfo: tableInfo)
        
        return true
        
        
    }
    
    
    
    func isTableExist(tableInfo:TableInfo) -> Bool{
        
        let sql = "SELECT COUNT(*) AS c FROM sqlite_master WHERE type ='table' AND name ='\(tableInfo._myTableName)'"
        
        let resultset = self.query(sql: sql, values: [])
        
        if resultset.next() {
            
            
            let count = resultset.int(forColumn: "c")
            
            resultset.close()
            
            if count > 0  {
                
                return true
                
            }else{
                
                return false
            }
        } else{
            
            
            return false
        }
        
        
        
        
        
    }
    
    
    //MARK:dbopration
    
    //MARK:查询
    private func query(sql:String ,values:[Any]) -> FMResultSet{
        
        
        var set:FMResultSet =  FMResultSet()
        
        
        databasepool?.inDatabase({ (db) in
            let db = db!
            
            set = db.executeQuery(sql, withArgumentsIn: values)
            
            if db.hadError(){
                
                self.lastError = db.lastError()
            }
            
            
        })
        
        
        
        
        return set
    }
    
    //MARK:执行多个
    
    func excute(sqls:Array<String>) -> Bool{
        
        var state = false
        
        databasequeqe!.inTransaction { (db, roollback) in
            let db = db!
            
            for sql in sqls{
                
                state = db.executeUpdate(sql, withParameterDictionary: nil)
                
                if !state{
                    break
                }
                
            }
            
            
            if state {
                
                db.commit()
                
            }else{
                
                
                
                self.lastError = db.lastError()
                
                debugPrint("=====\(roollback)")
                
                db.rollback()
                
            }
            
            
        }
        
        return state
    }
    
    
    
    
    
    //MARK:查询之外的语句
    private func excute(sql:String, param:Dictionary<String, Any>?) -> Bool{
        
        
        var state = false
        
        
        databasepool!.inDatabase { (db) in
            
            let db = db!
            
            state = db.executeUpdate(sql, withParameterDictionary: param)
            
            if state{
                
                db.commit()
                
            }else{
                
                self.lastError = db.lastError()
                
                
            }
            
            
        }
        
        
        
        
        
        return state
        
    }
    
    
    
}
