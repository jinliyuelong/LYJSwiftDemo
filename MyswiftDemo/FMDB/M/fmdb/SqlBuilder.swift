//
//  SqlBuilder.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/13.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class SqlBuilder: NSObject {
    
    //MARK:删除生成sql
    class func buildDeleteSql(myclass:AnyClass) -> String   {
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        var  desql = "DELETE FROM "
        
        
        desql.append(tableInfo._myTableName)
        
        return desql
        
        
    }
    
    //MARK:查询生成sql
    class   func buildQuerySql(myclass:AnyClass,columns:Array<String>?) ->  String {
        
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        var  querySql = "SELECT "
        if let columns = columns {
            if columns.count>0 {
                for i in 0 ..< columns.count {
                    
                    querySql.append(columns[i])
                    
                    querySql.append(",")
                    
                }
                querySql = querySql.substrfromBegin(length: (querySql.length - 1))
            }
            else{
                
                querySql.append("*")
            }
            
        }else{
            
            querySql.append("*")
            
        }
        
        
        
        
        querySql.append(" FROM ")
        querySql.append(tableInfo._myTableName)
        
        return querySql
        
    }
    
    
    
    
    //MARK:生成索引sql
    class   func buildcreateIndexSql(myclass:AnyClass,columns:Array<String>) ->  String {
        
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        var indexName = tableInfo._myTableName
        
        
        var  indexSql = "CREATE INDEX  "
        
        var behindSql = ""
        
        if columns.count>0 {
            for i in 0 ..< columns.count {
                
                indexName = indexName + columns[i]
                
                behindSql.append("'\(columns[i])'")
                
                behindSql.append(",")
                
            }
            behindSql = behindSql.substrfromBegin(length: (behindSql.length - 1))
            
            indexSql.append(indexName)
            
            
            indexSql.append(" ON \(tableInfo._myTableName) ( ")
            indexSql.append(behindSql)
            
            indexSql.append(" )")
            
        }
        
        
        
        
        
        return indexSql
        
    }
    
    
    //MARK: 创建表 语句 sql
    class   func buildCreatTableSql(myclass:AnyClass) ->  String {
        
        let tableInfo = TableInfo.getTableInfo(myclass: myclass)
        
        
        var  creatSql = "CREATE TABLE IF NOT EXISTS "
        creatSql.append(tableInfo._myTableName)
        
        creatSql.append("( ")
        
        
        
        
        for property in tableInfo._propertyMap! {
            
            let value = property.value as AnyObject
            
            if value.contains("NSNumber") {
                creatSql.append(property.key)
                creatSql.append(" INTEGER,")
            }else if value.contains("NSData"){
                creatSql.append(property.key)
                creatSql.append(" BLOB,")
            }else if value.contains("NSString"){
                creatSql.append(property.key)
                creatSql.append(" TEXT,")
            }else if value.contains("TB"){//bool
                creatSql.append(property.key)
                creatSql.append("  INTEGER,")
            }else if value.contains("Tq"){//Int
                creatSql.append(property.key)
                creatSql.append("  INTEGER,")
            }else if value.contains("Tf"){//float
                creatSql.append(property.key)
                creatSql.append("  REAL,")
            }else if value.contains("Td"){//double
                creatSql.append(property.key)
                creatSql.append("  REAL,")
            }else if value.contains("PrimaryKey"){
                creatSql.append(property.key)
                creatSql.append("  INTEGER PRIMARY KEY AUTOINCREMENT,")
            }else{
                //不支持的话，则忽略不创建
                
                continue
                
                //                assertionFailure("Name for \(property.key) element type - \(value) does not support ")
                
            }
            
        }
        
        
        creatSql = creatSql.substrfromBegin(length: (creatSql.length - 1))
        
        creatSql.append(")")
        
        return creatSql
        
    }
    
    
    //MARK:插入语句 sql
    class   func buildInsertSql(entity:AnyObject) ->  SqlInfo {
        let sqlInfo = SqlInfo()
        
        let tableInfo = TableInfo.getTableInfo(myclass: object_getClass(entity))
        
        
        
        var insertSql = "INSERT INTO  "
        
        
        insertSql.append(tableInfo._myTableName)
        
        insertSql.append(" (")
        
        
        
        let propertys = tableInfo._propertyMap!
        
        
        
        
        var insertSqlbehind :String = ""
        
        
        for property in propertys {
            
            let value = property.value as AnyObject
            
            if let entityvalue = entity.value(forKey: property.key) {
                
                
                if !value.contains("PrimaryKey")  {
                    
                    
                    
                    if value.contains("NSNumber") {
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                        
                    }else if value.contains("NSData"){
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        
                        let data = entityvalue as! Data
                        let dataString = data.base64EncodedString(options: .endLineWithLineFeed)
                        let entityvalue = "'\(dataString)'"
                        
                        insertSqlbehind.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                        
                        insertSqlbehind.append(",")
                    }else if value.contains("NSString"){
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("TB"){//bool
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("Tq"){//Int
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("Tf"){//float
                        
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("Td"){//double
                        insertSql.append(property.key)
                        
                        insertSql.append(",")
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        insertSqlbehind.append(entityvalue)
                        insertSqlbehind.append(",")
                        sqlInfo.arguments[property.key] = entityvalue
                    }else{
                        
                        //不支持的话，则忽略不创建
                        
                        continue
                        //                    assertionFailure("Name for \(property.key) element type - \(value) does not support ")
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        insertSqlbehind = insertSqlbehind.substrfromBegin(length: (insertSqlbehind.length - 1))
        
        insertSql = insertSql.substrfromBegin(length: (insertSql.length - 1))
        
        insertSql.append(") VALUES ( ")
        
        insertSql.append(insertSqlbehind)
        
        
        insertSql.append(")")
        
        
        
        
        sqlInfo.sql = insertSql
        
        sqlInfo.tableInfo = tableInfo
        
        return sqlInfo
        
        
    }
    
    //MARK:更新语句 sql
    class   func buildUpdateSql(entity:AnyObject) ->  SqlInfo {
        let sqlInfo = SqlInfo()
        
        let tableInfo = TableInfo.getTableInfo(myclass: object_getClass(entity))
        
        
        
        var updateSql = "UPDATE  "
        
        
        updateSql.append(tableInfo._myTableName)
        
        updateSql.append(" SET ")
        
        
        
        let propertys = tableInfo._propertyMap!
        
    
        
        for property in propertys {
            
            let value = property.value as AnyObject
            
            if let entityvalue = entity.value(forKey: property.key) {
                
                
                if !value.contains("PrimaryKey")  {
                    
                    
                    
                    
                    
                    if value.contains("NSNumber") {
                        
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                        
                    }else if value.contains("NSData"){
                        
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let data = entityvalue as! Data
                        let dataString = data.base64EncodedString(options: .endLineWithLineFeed)
                        
                        let entityvalue = "'\(dataString)'"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                        
                    }else if value.contains("NSString"){
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "'\(entityvalue)'"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                        
                    }else if value.contains("TB"){//bool
                        
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                        
                    }else if value.contains("Tq"){//Int
                        
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("Tf"){//float
                        
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                    }else if value.contains("Td"){//double
                        updateSql.append(property.key)
                        
                        updateSql.append(" = ")
                        
                        let entityvalue = "\(entityvalue)"
                        
                        
                        updateSql.append(entityvalue)
                        
                        sqlInfo.arguments[property.key] = entityvalue
                    }else{
                        //不支持的话，则忽略不创建
                        
                        continue
                        //                        assertionFailure("Name for \(property.key) element type - \(value) does not support ")
                        
                    }
                    
                    
                    updateSql.append(",")
                    
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        
        updateSql = updateSql.substrfromBegin(length: (updateSql.length - 1))
        
        
        sqlInfo.sql = updateSql
        
        sqlInfo.tableInfo = tableInfo
        
        return sqlInfo
        
    }
    
    
}
