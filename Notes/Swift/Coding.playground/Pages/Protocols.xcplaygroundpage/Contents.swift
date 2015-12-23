/// 协议 Protocols

/// 协议的语法
// 定义方式
/*
  // 定义协议
  protocol someProtocol{
    // 协议内容
  }

  // 结构体遵循协议，协议之间用","隔开
  struct SomeStructure:FirstProtocol, AnotherProtocol{
    // 结构体内容
  }

  // 如果类有父类，把父类名写在所有协议之前，同样用","隔开
  class SomeClass:SomeSuperClass, FirstProtocol, AnotherProtocol{
   // 类的内容
  }
*/

/// 对属性的规定
/*
   如果协议规定属性是可读可写的，那么这个属性不能是常量或只读的计算属性。如果协议只要求属性是只读的(gettable)，那个属性不仅可以是只读的，如果你代码需要的话，也可以是可写的。
*/
protocol SomeProtocol{
    var mustBeSettable:Int{ get set }   // 可读写
    var doesNotNeedToBeSettable:Int{ get }  // 可读
}

// 协议中定义类属性，以static开头,当协议的遵循者是类时，可以使用class或static关键字来声明类属性，但是在协议的定义中，仍然要使用static关键字。
protocol AnotherProtocol{
    static var someTypeProperty:Int{ set get }
}

// FullyNamed协议
protocol FullyNamed{
    var fullName: String{ get }
}

// 遵循FullyNamed协议，拥有fullName属性
struct Person:FullyNamed {
    var fullName: String   // 如果没有这个属性将会报错
}
let tom = Person(fullName: "tom")

// 此类完全遵循FullyNamed协议
class StarShip: FullyNamed {
    var prefix: String?
    var name: String
    
    init( name: String, prefix:String? = nil){
       self.name = name
       self.prefix = prefix
    }
    var fullName: String{
        return (prefix != nil ? prefix!+" ":"") + name
    }
}

let ss = StarShip(name: "Nolan", prefix: "Christopher")
print("\(ss.fullName)")

/// 对方法的规定
// 协议类方法依然是最前面用static
// 虽然你可以在类的实现中使用class或者static来实现类方法，但是在协议中声明类方法，仍然要使用static关键字。
protocol aProtocol{
  static func someTypeMethod()
}

protocol RandomNumberGenerator{   // 要求遵循者必须有random方法，而且返回值为Double
  func random() -> Double
}

// 此类遵循RandomNumberGenerator协议
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let a = 111234.3
    let b = 7834.12
    let c = 74.3
    
    func random() -> Double {   // 实现random方法
        lastRandom = ((lastRandom * a + b) % c)
        return lastRandom
    }
}

let generator = LinearCongruentialGenerator()
print("Random Number:\(generator.random())")

/// 对mutating方法的规定
/*
 用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
*/
protocol Togglable{
    mutating func toggle()  // 此方法将会改变遵循此协议的实例
}

enum OnOffSwitch: Togglable{
    case Off, On
    mutating func toggle() {  //  此方法修改了自身实例
        switch self{
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off // 初始为Off
lightSwitch.toggle()  // 被修改为On

/// 对构造器的规定
// 协议可以要求遵循者实现指定构造器，但不需要花括号和构造器实体
protocol bProtocol{
     init( someParameter: Int)
}

// 协议构造器规定在类中的实现
class aClass: bProtocol{
    required init(someParameter: Int) {   // 便利构造器或者指定构造器都必须给实现加上"required"
        // 实现构造器
    }
}

// 如果一个子类重写了父类的指定构造器，并且该构造器遵循了某个协议的规定，那么该构造器的实现需要被同时标示required和override修饰符
protocol Protocol{
    init()
}

class SuperClass {
    init(){
      // 实现构造器
    }
}

// 遵循协议，加上required， 重写父类的init方法，加上override
class SubClass: SuperClass, Protocol {
    required override init(){  // 构造器实现
    }
}

// 可失败构造器的规定
/*
  如果在协议中定义一个可失败构造器，则在遵顼该协议的类型中必须添加同名同参数的可失败构造器或非可失败构造器。如果在协议中定义一个非可失败构造器，则在遵循该协议的类型中必须添加同名同参数的非可失败构造器或隐式解析类型的可失败构造器（init!）。
*/

///  协议类型
// 协议本身不实现任何功能，协议可以被当做类型来使用。
/*
    ①作为函数、方法或构造器中的参数类型或返回值类型
    ②作为常量、变量或属性的类型
    ③作为数组、字典或其他容器中的元素类型
*/
class Dice{
    let sides: Int
    let generator: RandomNumberGenerator
    init( )
    
    
}








