

///  构造过程
// 构造过程是使用类，结构体，枚举等的一个准备过程，
// 通过构造器可以生成不同的特殊的实例，swift中的构造器没有返回值，主要是对实例进行初始化

/// 设置存储型属性的初始值

// 构造器,默认属性值
struct  Car{
    
    var name = "little Car😛"  //  这是一个默认属性值，如果它一般不被改变，比起写在init中，这种方式更好
    
    var speed:Double
    init(){  // 构造器，给属性赋初值
       speed = 10
    }
}

let s = Car.init()
print("\(s.name): \(s.speed)")

// 自定义构造过程
struct SpeedBySecond{

    var meterPerSec:Double
    init(meterPerSec mps:Double)  // 构造参数
    {
       meterPerSec = mps
    }
    
    init(kilometerPerHour kmph:Double)
    {
       meterPerSec = kmph / 3.6
    }
    func description()->String
    {
       return "The Speed is: \(meterPerSec) m/s"
    }
}

var sbs = SpeedBySecond.init(kilometerPerHour: 720)
print("\(sbs.description())")
sbs = SpeedBySecond.init(meterPerSec: 17)
print("\(sbs.description())")

// 参数的内部名称和外部名称，可选属性类型
struct Color{

    let r, g, b:Double
    var name:String?  // 可选属性类型，默认在初始化时为nil
    
    init(Red r:Double, Green g:Double, Bule b:Double)
    {
       self.r = r
       self.g = g
       self.b = b
    }
    
    init( _ w:Double) // 不带外部参数名，使用"_"代替外部参数名
    {
       r = w
       g = w
       b = w
    }
}

var c = Color.init(Red: 1.0, Green: 0.4, Bule: 0.5)  // 带外部参数名的构造方法必须这么写，否则会报错
c = Color.init(0.9)  // 这个构造方法不带参数名

print("\(c.name)") // 可选属性是空的
c.name = "Color"

// 常量属性的修改
// 可以在构造过程的任何时候修改常量属性，一旦结束构造过程就不能被修改
// 常量属性只能在自身类的构造过程中修改，不能被子类修改

struct Name {
    let n:String
    init(){
      n = "this is a name!"
    }
}

/// 默认构造器
// 没有自定义构造器的情况下会自动创建一个构造器,按照属性的默认值创造一个实例
class Student{
    var name = "Student"
    var score = 100
    var sex = true
    var birth:String?
}

var stu = Student()
print("\(stu.name), \(stu.score), \(stu.sex), \(stu.birth)")


/// 逐一成员的构造器
// 存储型属性提供了默认值，但是没有自定义构造，会获得一个逐一成员构造器
struct Size{
    var width, height:Double
    var description:String?
}

let si = Size(width: 1.2, height: 3.3, description: nil)

/// 值类型的构造器代理
// 通过调用其它构造器来完成构造过程称之为构造器代理，可以减少代码重复
struct Seconds{
    
    var sum:Int = 0
    var description:String = ""
    
    init(){}
    init(minutes m:Int){
        self.init(seconds:m * 60)
    }
    
    init(seconds s:Int){
      sum = s
       description = "\(sum)s."
    }
}

var sec = Seconds.init(minutes: 5)
print("\(sec.description)")

sec = Seconds.init(seconds: 79)
print("\(sec.description)")

/// 类的继承和构造过程
/*
   ①类的所有存储属性（包括从父类继承来的）都必须在构造过程中设定初始值
   ②指定构造器和便利构造器，保证类的所有存储属性都能获得初始值
   ③指定构造器完成所有属性初始化以及父类初始化
*/

/*
  init(parameters){   // 指定构造器写法与值类型简单构造器相同
     statements
  }

  convenience init(parameters){   // 便利构造器在init前加 convenience 关键字
    statements
  }

 */

/// 构造器代理规则,看这里的图：[#Image(imageLiteral: "initializerDelegation02_2x.png")#]
/*
   ① 指定构造器，必须只是向上代理
   ② 便利构造器，必须只是横向代理
*/

/// 两段式构造过程

/*
  Swift为了两段式构造的顺利完成，会进行安全检查：

安全检查 1
指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。

安全检查 2
指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。

安全检查 3
便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。

安全检查 4
  构造器在第一阶段构造完成之前，“不能调用任何实例方法、不能读取任何实例属性的值，self的值不能被引用。”

*/

/*
  两段式构造阶段

阶段 1
某个指定构造器或便利构造器被调用；
完成新实例内存的分配，但此时内存还没有被初始化；
指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化；
指定构造器将调用父类的构造器，完成父类属性的初始化；
这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部；
当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段1完成。

阶段 2
从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。

*/

/// 构造器的继承和重写
// 与OC不同，Swift中子类不会默认继承父类的构造器，子类仅会在确定且安全的情况下继承父类的构造器

class Animal {   // 此类自动生成一个默认构造器，默认构造器通常是指定构造器
    var numberOfLegs = 0
    var description:String{
      return "it has \(numberOfLegs) legs."
    }
}

class Dog: Animal {
    override init(){
        super.init()
        numberOfLegs = 4  // 子类只能给继承自父类的变量重新赋值，常量不可
    }
}

let a = Animal()
let d = Dog()
print("\(a.description)")
print("\(d.description)")

// 自动构造器的继承

/*
  为子类引入新属性需要遵守：
  规则1：如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器
  规则2：如果子类完成了所有父类指定构造器的实现，不管是通过规则1继承来的还是自定义实现的-它将自动继承所有父类的便利构造器。
*/

class Food {
    
    var name:String
    init(name:String){
      self.name = name
    }
    
    convenience init(){
        self.init(name:"[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity:Int
    init(name:String, quantity:Int){
      self.quantity = quantity  // 完成属性赋值
      super.init(name: name)  // 向上代理父类的构造器
    }
    
    // 于重写了父类的init(name:String) 构造器，所以要加 override
    override convenience init(name: String) {
        self.init(name:name, quantity:1)  // 此便利构造器简单的将任务代理给指定构造器
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description:String{
      var output = "\(name) x \(quantity)"
      output += purchased ? "✔": "✘"
      return output
    }
}

var breakfastList = [
     ShoppingListItem(),
     ShoppingListItem(name: "sugar"),
     ShoppingListItem(name: "egg", quantity: 6)
]

breakfastList[0].purchased = true
breakfastList[0].name = "Orange Juice"
print("\(breakfastList[0].description)")

for sfi in breakfastList{
   print("\(sfi.description)")
}

/// 可失败构造器
struct Company{
    var name:String
    
    init?(name:String){  // 这里name允许是空值，空值将返回空实例
        if(name.isEmpty){ return nil}   // 空字符串"" 与nil是不同的概念
        self.name = name
    }
}

let goo = Company(name: "Google")
print("\(goo!.name)")

let co = Company(name: "")
if co == nil{
   print("it's a Instance！")
}

/// 枚举类型的可失败构造器
enum CodingLanguage{
  case C, SWIFT, OC, JS, PHP
    init?(coding:Character){
        switch(coding){
          case "C":
            self = .C
          case "S":
            self = .SWIFT
          case "O":
            self = .OC
          case "J":
            self = .JS
          case "P":
            self = .PHP
          default :
            return nil
        }
    }
    
}

func isCodingLanguage( cl:CodingLanguage?)->Bool{
    if cl == nil{
        return false
    }
    return true
}

let cl0 = CodingLanguage(coding: "Q")  // 不属于枚举中的一个
let cl1 = CodingLanguage(coding: "S")  // 属于枚举中的一个

isCodingLanguage(cl0)
isCodingLanguage(cl1)

// 带原始值的可失败构造器
enum Coding:Character{
    case C = "C", Swift = "S", OC = "O", JS = "J", PHP = "P"
}

// rawValue 默认参数，和枚举的原始值类型相同，如果匹配则init一个枚举成员，否则为nil
let c1 = Coding(rawValue: "S")  // 默认值为S，init成功
let c2 = Coding(rawValue: "X")  // 默认值为X，无对应，init失败

/// 类的可失败构造器
class Product{
    var name:String!
    init?(name:String){   // name有默认属性值nil，
       self.name = name
        if name.isEmpty{ return nil }  // 必须在构造失败前给name属性一个值
    }
}

if let p = Product(name: "Mac"){
   print("The Product name: \(p.name)")    // 如果构造成功，name属性一定是有值的
}

// 构造失败的传递
// 可横向代理其它失败构造器，子类可以向上代理父类的可失败构造器，无论什么情况，一旦构造失败就不再执行以后的构造代码
class CartItem:Product{
    var quantity:Int!
    
    init?(name:String, quantity:Int){
       super.init(name: name)   // 向上代理父类的可失败构造器
       if quantity < 1{ return nil }  // 如果quantity<1 即停止构造，代码结束
        self.quantity = quantity
    }
}

if let ci0 = CartItem(name: "Egg", quantity: 10){
  print("Item:\(ci0.name) Quantity:\(ci0.quantity)")
}

if let ci1 = CartItem(name: "Pen", quantity: 0){   // quantity为0 导致的构造失败
    print("Item:\(ci1.name) Quantity:\(ci1.quantity)")
}
else{
    print("Initialize failed!")
}

if let ci2 = CartItem(name: "", quantity: 10){  // name为nil 导致的构造失败
    print("Item:\(ci2.name) Quantity:\(ci2.quantity)")
}
else{
    print("Initialize failed!")
}

// 重写可失败构造器
class Document{
    var name:String?
    init(){}   //  创建一个name为nil的Document实例
    init?(name:String){   // 创建一个name不为空的Document实例
        
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument:Document{
    
    override init(){
      super.init()
      name = "[Untitled]"
    }
    
    override init(name: String) {   // 用非可失败构造器重写父类的可失败构造器，通过非空处理，确保构造成功
       super.init()     // 一旦这样写，将不能代理父类的可失败构造器
        if name.isEmpty{
           self.name = "[Untitled]"
        }
        else{
           self.name = name
        }
    }
}

class UntitledDocument: Document {
    
    override init() {
        super.init(name: "[Untitled]")!   // 调用父类的可失败构造器强制解包，以实现子类的非可失败构造器。
    }
}

// 可失败构造器 init!
/*
  通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以使用通过在init后面添加惊叹号的方式来定义一个可失败构造器(init!)，该可失败构造器将会构建一个特定类型的隐式解析可选类型的对象。

  你可以在 init?构造器中代理调用 init!构造器，反之亦然。 你也可以用 init?重写 init!，反之亦然。 你还可以用 init代理调用init!，但这会触发一个断言： init! 构造器是否会触发构造失败？

*/

/// 必要构造器
// 在构造器前加 require表示所有子类都要实现这个构造器
class SuperClass{
    required init(){
      // 在这里添加构造器实现的必要代码
    }
}

class AClass: SuperClass {
    required init() {  // 重写父类的必要构造器，不需要在前面添加override 但是需要require
        // 在这里添加必要代码
    }
}

/// 通过闭包和函数来设置属性的默认值

// 示例如下：
 class SomeClass {
    let someProperty: String = {       // 属性及类型
    // 在这个闭包中给 someProperty 创建一个默认值
    // someValue 必须和 SomeType 类型相同
    return ""      // 返回相同类型
    }()   // 这个小括号表示立即执行，如果没有小括号表示给属性赋值了这个闭包
 }

// 跳棋棋盘示例
struct Checkerboard{

    let boardColors:[Bool] = {
     
       var tempBoard = [Bool]()
       var isBlack = false
       
        for i in 1...10{
            for j in 1...10{
              tempBoard.append(isBlack)
              isBlack = !isBlack
            }
            isBlack = !isBlack
        }
      return tempBoard
    }()    // 通过此闭包直接初始化属性
    
    func squaresBlackAtRow(row r:Int, column:Int)->Bool{
      return boardColors[(r * 10) + column]
    }
}

let board = Checkerboard()
print("\(board.squaresBlackAtRow( row:0, column:1))")  // 1行2列位置
print("\(board.squaresBlackAtRow( row:9, column:9))")  // 10行10列位置


