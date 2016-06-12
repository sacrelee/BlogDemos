//
//  FMDBManager.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/25.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import Foundation
import FMDB

let LineModelTableName = "LinesDataTable"

class FMDBManager{
    
    static let defaultManager = FMDBManager()  // 单例
    let fmdbQueue:FMDatabaseQueue?
    
    private init(){
       let dbPath = try! NSFileManager.defaultManager().URLForDirectory(.LibraryDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false).URLByAppendingPathComponent("database.sqlite")
       fmdbQueue = FMDatabaseQueue(path: dbPath.path)
       self.createOpenDatabase()
    }
    
    func createOpenDatabase(){
        
        fmdbQueue?.inDatabase(){
               db in
            if db.open() == true {
              print("create / open database success!")
            }
            else{
              print("create / open database failed!")
            }
        }
    }
    
    func createTable(){
        
        if NSUserDefaults.standardUserDefaults().boolForKey("TableCreated") == true {
           print("the table is already exists!")
           return
        }
        
        let SQLStr = "create table if not exists \(LineModelTableName) ( lineId integer primary key autoincrement, paintingId integer, colorIndex integer, width real, points text)"
        if self.executeSQL(SQLString: SQLStr) == true {
            NSUserDefaults.standardUserDefaults().setBool( true, forKey:"TableCreated")
           print("create Table success!")
        }
        else{
          print("create Table failed!!!")
        }
    }
    
    func saveLineModels(lineModels lms:[LineModel]) -> Bool{
      
        if lms.count == 0 {
           return true
        }
        
        // clear old data
        let clearTable = "delete from \(LineModelTableName) where paintingId = 0"
        self.executeSQL(SQLString: clearTable)
        
        var success = true
        fmdbQueue?.inTransaction(){
            db, rollback in
            
            for lm in lms {
                if db.executeUpdate(self.getModelInsertSQLString(lineModel: lm, paintingId: 0), withArgumentsInArray: nil) == false {
                    rollback.initialize(true)
                    success = false
                    break
                }
            }
        }
        return success
    }
    
    func getModelInsertSQLString(lineModel lm:LineModel, paintingId pId:NSInteger) -> String{
        var pointsStr = "'["
        for point in lm.points {
           pointsStr += "\"\(point.x),\(point.y)\","
        }
        pointsStr += "]'"
        
        return "insert into \(LineModelTableName)(paintingId, colorIndex, width, points) values(\(pId), \(lm.colorIndex), \(lm.width), \(pointsStr))"
    }
    
    func getLineModelArray() -> [LineModel]? {

        let sql = "select * from \(LineModelTableName) where paintingId = 0"
        var models:[LineModel] = []

//        _ = ""
        
        fmdbQueue?.inDatabase(){
           db in
           let resultSet = db.executeQuery( sql, withArgumentsInArray: nil)
            while resultSet.next(){
                
//                let cn = NSClassFromString(className) as! NSObject.Type
//                let model = cn.init()
                
         
         
                let lm = LineModel()
                lm.width = CGFloat(resultSet.doubleForColumn("width"))
                lm.colorIndex = NSInteger(resultSet.intForColumn("colorIndex"))
                let points = try! NSJSONSerialization.JSONObjectWithData((resultSet.objectForColumnName("points") as! String).dataUsingEncoding(NSUTF8StringEncoding)!, options:.AllowFragments) as! [String]
                
                var x:CGFloat = 0.0
                var y:CGFloat = 0.0
                for pointStr in points {
                   let xy = pointStr.componentsSeparatedByString(",")
                   x = CGFloat((xy[0] as NSString).doubleValue)
                   y = CGFloat((xy[1] as NSString).doubleValue)
                   lm.points.append(CGPointMake( x, y))
                }
                
                let count = UnsafeMutablePointer<UInt32>.alloc(1)
                count.initialize(0)
                
                let propertyList = class_copyPropertyList( lm.classForCoder, count)
                
                for i in 0...(Int(count.memory) - 1) {
                    
                    let char = property_getName(propertyList[Int(i)])
                    print("Property---->\(NSString.init(UTF8String: char))")
                    
                    
                    
                }

                
                models.append(lm)
            }
        }
        return models
    }
    
    func executeSQL(SQLString sql:String) -> Bool {
        
        var result = false
        fmdbQueue?.inDatabase(){
            db in
            result = db.executeUpdate(sql, withArgumentsInArray: nil)
        }
        return result
    }
    
}
