///  Automatic Reference Counting(ARC) 自动引用计数
// Swift使用ARC管理类实例的内存占用。PS：ARC仅仅应用于类的实例，结构体、枚举都属于值类型，不是引用类型


/// 自动引用计数的工作机制
// 将实例赋给常量、变量、属性，都是强引用。只要强引用还在，这个实例就不会被释放。

/// 自动引用计数实践


class Person {
    let name:String
    var apartment:Apartment?
    init(name:String){
      self.name = name
      print("\(name) is being initialized")
    }
    
    deinit{
       print("\(name) is being deinitialized")
    }
}

var reference1:Person?
var reference2:Person?
var reference3:Person?

reference1 = Person(name: "Linus") // 生成了一个实例，有1个强引用
reference2 = reference1   // 此实例强引用 +1
reference3 = reference1   // 此实例强引用 +1，当前强引用数：3

reference2 = nil   // 强引用 -1
reference3 = nil   // 强引用 -1
reference1 = nil   // 强引用为 0，实例被释放

/// 类实例之间的循环强引用
class Apartment{
   
    let unit:String
    var person:Person?
    init(unit:String){ self.unit = unit }
    deinit{ print("Apartment:\(unit) is being initialized") }
}

var larry:Person?   // 带有一个Apartment属性，
var apart:Apartment?   // 带有一个Person属性

larry = Person(name: "Larry")
apart = Apartment(unit: "5X")

larry?.apart =

