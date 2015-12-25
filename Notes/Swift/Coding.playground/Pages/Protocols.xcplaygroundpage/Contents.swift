/// 协议 Protocols

import Foundation

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
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {   // 实现random方法
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
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
class Dice{   // 定义一个骰子
    let sides: Int   // 骰子有几面
    let generator: RandomNumberGenerator  //  生成投掷的随机数
    init( sides: Int, generator: RandomNumberGenerator){
       self.sides = sides
       self.generator = generator
    }
    
    func roll() -> Int{
       return Int( generator.random() * Double(sides)) + 1
    }
}

// 实例化一个6面骰子
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5{
   print("Random Dice roll is \(d6.roll())")
}

/// 委托(代理)模式
// 属于一种设计模式，允许类、结构体，将一些功能交付给委托实例实现，与OC无异

/*
   示例
*/
enum ComputingType{  // 两种计算类型，和、积
    case sum, product
}

protocol computingDelegate{ // 计算的协议
    func willBeginComputing( numbers:[Double], computingType:ComputingType )  // 即将计算，传入待计算的数组和计算类型
    func DidEndComputing() -> Double  // 计算结束，返回计算结果
}

class Computer {   // 此类不负责实际计算，所有计算由代理完成
    var numbers: [Double]
    var delegate: computingDelegate?
    
    init( numbers:[Double]){
       self.numbers = numbers
    }
    
    func sum(){
        if computing( .sum) != nil{
          print("The sum is \(computing( .sum))")
        }
    }
    
    func product(){
        if computing( .product) != nil{
         print("The product is \(computing( .product))")
        }
    }
    
    func computing( computingType:ComputingType) -> Double?{
        
        if delegate != nil {    // 代理不为空时，可以计算
           delegate!.willBeginComputing(numbers, computingType: computingType)
           return delegate!.DidEndComputing()
        }
        else{   // 代理为空时，打印错误信息
            print("I need a Delegate")
            return nil
        }
    }
}

class Operator: computingDelegate{   // 此类是代理方，为实际计算者。
    
    var result:Double?
    
    func willBeginComputing( numbers:[Double], computingType:ComputingType ) { // 实现计算方法
        
         result = computingType == .sum ? 0.0: 1.0
        for number in numbers{
            if computingType == .sum{
              result! += number
            }
            else{
              result! *= number
            }
        }
    }

    func DidEndComputing() -> Double {   // 实现结果返回方法
        return result!
    }
}

var cpr = Computer(numbers: [1, 2, 3, 4, 5, 6])  // 创建一个计算实例
cpr.sum()  // 当前没有代理，会报错
cpr.delegate = Operator()  // 添加代理
cpr.product()  // 有代理，完成计算


/// 在扩展中添加协议成员
// 通过扩展为已存在的类型遵循协议时，该类型的所有实例也会随之添加协议中的方法
protocol TextRepresentable{
  func asText() -> String
}

extension Dice: TextRepresentable{    // Dice的所有实例都遵循了TextRepresentable
    func asText() -> String{
      return "A \(sides)-sided dice"
    }
}

let d14 = Dice(sides: 14, generator: LinearCongruentialGenerator())
print("\(d14.asText())")

// 其它类也可以通过扩展方式遵循TextRepresentable协议


/// 通过扩展补充协议声明
// 某类已实现了某协议的所有要求，可以通过空扩展该协议来使该类符合协议类型

struct Hamster{   // 此类实现了TextRepresentable协议的所有要求
    var name:String
    func asText() -> String{
      return "A Hamster named \(name)"
    }
}

extension Hamster:TextRepresentable{}  // 空扩展，Hamster可以作为TextRepresentable类型使用

let simonTheHamster = Hamster(name: "Simon")
// 即使满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出显式的协议声明
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print("\(somethingTextRepresentable.asText())")

/// 集合中的协议类型
// 协议可以在集合中使用，集合中的所有元素均符合此协议

// things数组中所有元素均符合TextRepresentable协议
let things:[TextRepresentable] = [d14, simonTheHamster]
for thing in things{
  print("\(thing.asText())")
}

/// 协议的继承
// 协议可继承其它一个或者多个协议，用","隔开，与类继承类似
/*
protocol InheritingProtocl: SomeProtocol, AnotherProtocol{
    // 协议定义
}
*/
protocol PrettyTextRepresentable: TextRepresentable{   // 此协议继承了TextRepresentable协议
   func asPrettyText() -> String
}

// 遵循此协议的类型，必须实现包括它父协议的所有要求
extension Hamster: PrettyTextRepresentable{
    func asPrettyText() -> String{
        let output = asText()[asText().startIndex.advancedBy(9) ..< asText().endIndex]
        return output + "√"
    }
}

let h = Hamster(name: "Tom")
print("\(h.asText())")
print("\(h.asPrettyText())")

/// 类专属协议
/*
  在协议的继承列表中添加class可以限制此协议仅适配到类，如果适配到其它类型会出现编译错误
  protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol{   // class在所有父协议之前

  }

  当协议想要定义的行为，要求（或假设）它的遵循类型必须是引用语义而非值语义时，应该采用类专属协议。
*/

/// 协议合成
// 有时需要同时遵循多个协议，格式类似protocol <SomeProtocol, AnotherProtocol>,称之为协议合成
// 栗子一个
protocol Named{
    var name:String { get }
}

protocol Aged{
    var age:Int { get }
}

struct Kid: Named, Aged{
    var name:String
    var age:Int
}

func wishHappyBirthday(celebrator: protocol< Named, Aged>){  // 参数是同时遵循两个协议的实例
   print("happy birthday:\(celebrator.name) - you are:\(celebrator.age).")
}

let birthKid = Kid(name: "Li Lei", age: 14)
wishHappyBirthday(birthKid)

// *PS: 协议合成并不会生成一个新协议类型，而是将多个协议合成为一个临时的协议，超出范围后立即失效。

/// 检验协议的一致性
// is和as操作符来检查是否遵循某一协议或强制转化为某一类型。
/*
  is 操作符用来检查实例是否遵循了某个协议
  as? 返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
  as 用以强制向下转型，如果强转失败，会引起运行时错误。
*/

// 1.定义协议
protocol HasArea{
    var area:Double { get }
}

// 2.定义实现了HasArea协议的Circle和Country类
class Circle: HasArea {   // 遵循协议，将area作为基于存储型属性radius的计算型属性
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init( radius:Double){
      self.radius = radius
    }
}

class Country: HasArea {  // 遵循协议，将area作为存储型属性实现
    var area: Double
    init( area:Double){
      self.area = area
    }
}

// 3.定义没有实现HasArea协议的Animal类
class Animal{
    var legs: Int
    init( legs: Int){ self.legs = legs }
}

// 4.以上三者的实例可以作为AnyObject存储到一个数组
let objects:[AnyObject] = [Circle(radius: 1.2), Country(area: 2099), Animal(legs: 4)]

for object in objects{
    if let objectWithHasArea = object as? HasArea{
      print("Area is \(objectWithHasArea.area)")
    }
    else{
      print("Something that doesn't have an area.")
    }
}

/// 对可选协议的规定
// 协议含有可选成员，遵循者可以自行选择是否实现这些成员，使用optional前缀来标记这类成员
// 此类成员在调用时使用 可选链
/*
  ①可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循这个前缀表示协议将暴露给Objective-C代码，即使你不打算和Objective-C有什么交互，如果你想要指明协议包含可选属性，那么还是要加上@obj特性。
  ②标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类采纳，其他类以及结构体和枚举均不能采纳这种协议。
*/

// ①可选的协议
@objc protocol CounterDataSource{
    optional func incrementForCounter( counter:Int) -> Int
    optional var fixedIncrement: Int { get }
}

// ②Counter类
class Counter{
   var count = 0
    var dataSource:CounterDataSource?
    func increment(){
        if let amount = dataSource?.incrementForCounter?(count){
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement{  // fixedIncrement本身就是一个可选值
            count += amount
        }
    }
}

// ③数据源类
class ThreeSource: NSObject, CounterDataSource{
   let fixedIncrement = 3
}

// ④将ThreeSource实例添加到Counter实例
let counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4{
   counter.increment()   // 可以取到fixedIncrement = 3,每次循环增加3
   print(counter.count)
}

// ⑤更复杂的TowersZeroSource数据源
@objc class TowerZeroSource: NSObject, CounterDataSource{
    func incrementForCounter(counter: Int) -> Int {
        if counter == 0{
          return 0
        }
        else if counter < 0{
          return 1
        }
        else{
          return -1
        }
    }
}

// ⑥使用TowerZeroSource数据源
counter.count = -4
counter.dataSource = TowerZeroSource()
for _ in 1...5{
   counter.increment()  // 当count增加到0，就不会继续增加了
   print(counter.count)
}

/// 协议扩展
/*
  协议可以通过扩展来为采纳协议的类型提供属性、方法以及下标脚本的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个采纳协议的类型中都重复同样的实现，也无需使用全局函数。
*/
extension RandomNumberGenerator{
    func randomBool() -> Bool{
      return random() > 0.5
    }
}

// 通过协议扩展，所有采纳协议的类型，都能自动获得这个扩展增加的方法实现
let gtr = LinearCongruentialGenerator()
print("here is a random number:\(gtr.random())")
print("And here is a random Boolean:\(gtr.randomBool())")  // 实例gtr自动获取了randomBool方法的实现

// *提供默认方法实现
/*
 可以通过协议扩展来为协议要求的属性、方法以及下标脚本提供默认的实现。如果采纳协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。

PS:通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，采纳协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
*/
extension PrettyTextRepresentable{   // 扩展此协议，简单的添加了一个默认属性
    var prettyTextureDescription:String{
       return self.prettyTextureDescription
    }
}

// *为协议扩展添加限制条件
/*
  在扩展协议的时候，可以指定一些限制条件，只有采纳协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。
  这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句)中所描述的。
*/

// 扩展CollectionType协议，仅应用于集合中元素遵循了TextRepresentable协议的情况

//extension CollectionType where Generator.Element: TextRepresentable {
//    func asList() -> String {
//        var rtnString:String = "("
//        rtnString.appendContentsOf(map({$0.asText()}).description+")")
//        return rtnString
//}



/**
*	@author SACRELEE, 2015-12-25 18:12:34
*
*	目前不清楚问题出在哪，
*/
extension CollectionType where Generator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map ({ $0.textualDescription })
        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
}
    
    
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamster.texturalDescription)








