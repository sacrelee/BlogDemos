/// 下标脚本
// 定义在类，枚举，结构体中，是访问集合，列表，序列的快捷方式

// 访问数组元素 array[index],访问字典 dictionary[key]

/// 下标脚本语法

// subscript(index:Int)->Int{   //可读写类型，实现赋值和获取值的方法
//    get{  // 获取值 }
//    set(newValue){ // 赋值 }
// }

// subscript(index:Int) -> Int{  //只读类型，返回原类型值 }

struct fileName {
    let name:String
    subscript(index:Int)->String{   // 返回值要保持一致
       return "\(index).---" + name
    }
}

let fn = fileName(name: "app.ipa")
print("\(fn[6])") // 使用下标脚本，为其添加序号（相当于访问了fn中的第6个元素）

/// 下标脚本的用法

// 字典
var dict = ["Android":"Microsoft", "iOS":"Apple", "Windows":"Google"]

dict["Android"] = "Google" // 修改为正确的值
dict["Windows"] = nil  // 这里删除了这个键值对

print("\(dict)")

// 数组
var array = ["Google", "Apple", "Microsoft"]
print("\(array[0])")
array[0] = "IBM"  // 修改数组中的元素

/// 下标脚本选项

struct Student{
   
    var description = ""
    
    func handleData(name:String?, score:Double)->Bool{
        
        if score >= 0 && score <= 100{
            return true
        }
        return false
    }
    
    subscript( name :String?, score :Double)->String{
        get{
         assert( handleData(name, score: score),"Error Data")
             return name! + ":\(score)"
        }
        set{
          assert( handleData(name, score: score), "Error Data")
            description = name! + ":\(score)"
        }
    }
}

let s = Student()

print(s["",-123])