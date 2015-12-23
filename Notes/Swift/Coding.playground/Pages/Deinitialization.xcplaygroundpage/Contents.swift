import Foundation
/// 析构过程 Deinitialization
// 适用于类类型，析构器用deinit来标识，就像构造器用init一样

/// 析构过程原理
// Swift用自动引用计数（ARC）来管理内存，通常不需要手动处理实例的内存释放。
// 析构器适用于处理自己的资源

/*
  ①一个类有且仅有一个析构器，并且不带任何参数
  ②析构器会被自动调用并且不允许主动调用
  ③子类自动继承父类的析构器，即使子类没有析构器，父类的析构器也会被自动调用

  deinit{
    // 析构过程
  }

*/

/// 析构器操作

// 全局设置操作器
class SettingManager{
    
    static let sharedInstance = SettingManager()  // 获取单例
    
    let settingFilePath = NSHomeDirectory().stringByAppendingString("/Library/Settings.json")
    
    var settingsDict = [String: AnyObject]()
    
    private init(){   // 初始化设置操作器，如果有配置文件就载入

       if let settingData = NSData.init(contentsOfFile: settingFilePath) {

        do{
            // 获取到之前存储的配置
            settingsDict = try NSJSONSerialization.JSONObjectWithData(settingData, options: NSJSONReadingOptions.MutableContainers)  as! Dictionary
            
            if settingsDict.count != 0 {
                try NSFileManager.defaultManager().removeItemAtPath(settingFilePath)
            }
        }
        catch{
            print("Setting File Error!")
         }
     }
    }
    
    func setValue(key k:String, value b:AnyObject){    // 设定或者添加一条配置信息
        settingsDict[k] = b
    }
    
    func value(key k:String)->AnyObject?{    // 获取某条配置信息
       return settingsDict[k] 
    }
    
    deinit{   // 析构器，释放内存前将所有设置保存到磁盘
        if NSKeyedArchiver.archiveRootObject(settingsDict, toFile: settingFilePath){
           print("save settings successfully!")
        }
    }
}
   
SettingManager.sharedInstance.setValue(key: "first", value:"the first value")
SettingManager.sharedInstance.setValue(key: "second", value:["1","2","3"])
print("\(SettingManager.sharedInstance.value(key: "second"))")


