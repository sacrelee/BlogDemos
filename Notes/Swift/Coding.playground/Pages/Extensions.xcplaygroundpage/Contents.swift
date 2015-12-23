/// Extensions扩展
// 扩展是向已有类、结构体、枚举或者协议类型添加新功能，与OC中的Categories类似，不同的是Swift中扩展没有名字
// 扩展可以增加功能而不能重写已有功能
/*
    ①添加计算型属性和计算型静态属性
    ②定义实例方法和类型方法
    ③提供新的构造器
    ④定义下标
    ⑤定义和使用新的嵌套类型
    ⑥使一个已有类型符合某个协议
*/

/// 扩展语法 Extension Syntax
/*
  // 扩展某个类型
   extension someType{
    // 要扩展的新功能写在这里
  }

  // 扩展已有类型，使其适配一个或者多个协议
   extension someType: someProtocol, AnotherProtocol{
    // 协议的实现写在这里
  }
 
  PS:扩展一旦添加，对应的所有实例都是可用的
*/

/// 计算型属性
// 扩展可以添加计算型属性，不可以添加存储属性，也不能添加属性观测器
extension Double{
    var km:Double { return self * 1_000.0}
    var m:Double  { return self }
    var cm:Double { return self / 100.0 }
    var mm:Double { return self / 1_000.0}
    var ft:Double { return self / 3.28048}
}

let oneInch = 25.4.mm
print("One Inch is \(oneInch) meters")

let threeFeet = 3.ft
print("The feet is \(threeFeet) meters")

let marathon = 42.km + 195.m
print("A marathon is \(marathon) meters long.")

/// 构造器
// 扩展可以添加新的构造器，不能添加指定构造器和析构器，这两者一定是原始类提供的
/*
  如果你使用扩展向一个值类型添加一个构造器，在该值类型已经向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers）时，你可以在值类型的扩展构造器中调用默认构造器(default initializers)和逐一成员构造器(memberwise initializers)。
*/
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// 扩展Rect
extension Rect{
    init( center: Point, size: Size){    // 计算原点并初始化一个Rect实例
      let originX = center.x - size.width / 2.0
      let originY = center.y - size.height / 2.0
        self.init( origin: Point(x: originX, y: originY), size:size)
    }
}

let centerRect = Rect(center: Point( x: 9.5, y: 5.0), size: Size( width: 5.0, height: 4.0))

/// 方法
// 可以向已有类型添加实例方法或者类型方法
extension Int{
    // repeitions使用了一个()->()类型的单参数，此函数没有参数和返回值
    func repeitions( task:() -> ()){  // 调用此扩展方法，重复执行某任务
        for _ in 1..<self{
          task()
        }
    }
}

4.repeitions( {print("hello1")} )   // 重复三次执行
4.repeitions{ print("hi!") } // 尾随闭包使其更加简洁

// 修改实例方法
extension Int{
    mutating func square(){   // 修改self，方法前加mutating
      self = self * self
    }
}
var someInt = 3
someInt.square()  // someInt现在为9

/// 下标
// 扩展可以向一个已有类型添加新的下标
extension Int{

    subscript(var digitIndex:Int) -> Int{
        
        var decimalBase = 1
        
        while digitIndex > 0{
          decimalBase *= 10
          --digitIndex
        }
        return (self / decimalBase) % 10
    }
}

73695841[0]
73695841[1]
73695841[2]
73695841[3]
73695841[8]  // 如果越界，会在左侧自动补全0，等同于 073695841[8]

/// 嵌套类型
// 扩展可以向已有类、结构体、枚举添加新的嵌套类型
extension Int{
  
    enum Kind{
      case Negative, Zero, Positive
    }
    var kind: Kind{
        switch self{
        
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive   // 正数
        default:
            return .Negative  // 负数
        }
    }
}

 // 已知number.kind是Int.kind型，因此Int.kind所有成员值都可以使用switch语句里的形式简写
func printIntegerKinds(numbers:[Int]){
    
    for number in numbers{
        switch number.kind{
        case .Negative:
            print("-",terminator: "")
        case .Zero:
            print("0", terminator: "")
        case .Positive:
            print("+", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])





