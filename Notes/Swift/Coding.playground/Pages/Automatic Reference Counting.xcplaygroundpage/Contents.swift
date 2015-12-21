///  Automatic Reference Counting(ARC) 自动引用计数
// Swift使用ARC管理类实例的内存占用。PS：ARC仅仅应用于类的实例，结构体、枚举都属于值类型，不是引用类型


/// 自动引用计数的工作机制
// 将实例赋给常量、变量、属性，都是强引用。只要强引用还在，这个实例就不会被释放。

/// 自动引用计数实践


class Dog {
    let name:String
    init(name:String){
      self.name = name
      print("\(name) is being initialized")
    }
    
    deinit{
       print("\(name) is being deinitialized")
    }
}

var reference1:Dog?
var reference2:Dog?
var reference3:Dog?

reference1 = Dog(name: "Cat!") // 生成了一个实例，有1个强引用
reference2 = reference1   // 此实例强引用 +1
reference3 = reference1   // 此实例强引用 +1，当前强引用数：3

reference2 = nil   // 强引用 -1
reference3 = nil   // 强引用 -1
reference1 = nil   // 强引用为 0，实例被释放


/// 类实例之间的循环强引用
class  Person{
    let name:String
    var apart:Apartment?
    init(name:String){ self.name = name }
    deinit{ print("\(name) is being deinitialized")}
}

class Apartment{
    let unit:String
    var person:Person?
    init(unit:String){ self.unit = unit }
    deinit{ print("Apartment:\(unit) is being deinitialized") }
}

var larry:Person?   // 带有一个Apartment属性，
var apart:Apartment?   // 带有一个Person属性

larry = Person(name: "Larry")
apart = Apartment(unit: "5X")

larry?.apart = apart   // 这里建立两者的循环强引用
apart?.person = larry

larry = nil
apart = nil
// **将此两个变量置为nil，但是他们之前所对应的实例还互相持有强引用，因此都不会被释放，deinit都不会被执行

/// 解决实例间的循环强引用
// 弱引用（weak reference），无主引用（unowned reference）允许一个实例以非强引用方式引用另一个实例
// 生命周期中会变为nil的情况使用弱引用，初始化赋值后不会被置为nil时使用无主引用

// ①弱引用，两个变量均为可nil类型，使用这种方式打破循环强引用
class Person0{
    var name:String
    var apart0:Apartment0?
    init(name:String){ self.name = name }
    deinit{ print("\(name) is being deinitialized") }
}

class Apartment0{
    var name:String
    weak var person0:Person0?  // 弱引用只能是变量，
    init(name:String){ self.name = name }
    deinit{ print("Apartment:\(name) is being deinitialized")}
}

var jhon:Person0?
var apartment:Apartment0?

jhon = Person0(name: "Jhon")
apartment = Apartment0(name: "6A")

jhon!.apart0 = apartment   // 建立相互引用
apartment!.person0 = jhon

jhon = nil
apartment = nil
// **弱引用的存在使这两个循环引用的实例可以正常释放


// ②无主引用，一个变量可nil另一个变量不可nil，使用这种方式打破循环强引用
class Customer{
    let name:String
    var card:CreditCard?
    init(name:String){ self.name = name }
    deinit{ print("\(name) is being deinitialized") }
}

class CreditCard {
    let number:UInt64
    unowned let customer:Customer   // 每张信用卡必对应一个用户，此属性不可为空，因此通过无主引用来处理内存释放问题
    init(number:UInt64, customer:Customer){
      self.number = number
      self.customer = customer
    }
    deinit{ print("Card #\(number) is being deinitialized") }
}

var tom:Customer?

tom = Customer(name: "tom")

// custom实例对creditCard实例持有强引用，而creditCard实例对custom实例持有无主引用
tom!.card = CreditCard(number: 6228_8888_8888_888, customer: tom!)

tom = nil   // tom变量为nil，两个实例均被销毁

// ③无主引用以及隐式解析可选属性
// 存在这种情况，两个实例中属性均必须有值，初始化后永不为nil，
// 解决这种情况的循环强引用需要一个使用无主属性,另一个使用隐式解析可选属性

class Country {   // 国家必有名字和首都
    let name:String
    var capitalCity:City!   // 由于Country初始化后才可以把self传递给City的构造函数，这里使用隐式解析可选类型的属性
    init(name:String, capitalName:String){
       self.name = name    // 构造器结束到这一行就完成了初始化
       self.capitalCity = City(name: capitalName, country: self) // 上一步完成就可以将self作为参数传递给City的构造器
    }
}

class City {   // 城市必有名字和所属国家
    let name:String
    unowned let country:Country   // 对Country属性持有无主引用，避免强引用
    init(name:String, country:Country){
      self.name = name
      self.country = country
    }
}

var country = Country(name: "USA", capitalName: "Washington")   // 一行代码创建了两个实例，并且不会引起循环强引用
print("Country:\(country.name),Capital:\(country.capitalCity.name)")  // 可以直接取capitalCity属性，并不需要展开值

/// 闭包引起的循环强引用
// 闭包也是引用类型，因此也会出现循环强引用
// Swift通过闭包捕获列表来解决这个问题
class HTMLElement {
    let name:String
    let text:String?
    
    lazy var asHTML:Void -> String = {  // lazy属性，访问时才创建。可以将asHTML看成是没有参数返回值为String的函数(类型是Void->String)
        if let text = self.text{
          return "<\(self.name)>\(text)</\(self.name)>"
        }
        else{
          return "<\(self.name) />"
        }
    }
    
    init(name:String, text:String? = nil){
        self.name = name
        self.text = text
    }
    
    deinit{
       print("\(name) is being deinitialized")
    }
}

//  创建一个实例并修改asHTML闭包
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
  return "<\(heading.name)> \(heading.text ?? defaultText) </\(heading.name)>"
}
print("\(heading.asHTML())")

// 创建一个实例并打印消息
// asHTML闭包使用了self(引用self.name等)，因此持有此实例的强引用；原本此实例就持有asHTML闭包的强引用，因此出现循环强引用
var paragraph:HTMLElement? = HTMLElement(name: "p", text: "hello world")
print("\(paragraph!.asHTML())")
paragraph = nil   // 循环强引用，此实例不会被销毁

/// 解决闭包的循环强引用
// Swift规定闭包在引用属性时必须用self. 来取，这种规则提醒开发者做了哪些引用
// 定义捕获列表，捕获列表定义了闭包体捕获一个或者多个引用类型的规则


// 定义捕获列表
/*
    ①常规写法
    lazy var someClosure:( Int, String)->String = {
     
       [unowned self, weak delegate = self.delegate!]( index:Int, stringToProgress:String) -> String in
        // closure body goes here

    }
*/

/*
   ②没有参数或者返回值类型
   lazy var someClosure:Void -> String = {
     
    [unowned self, weak delegate = self.delegate!] in 
     // closure body goes here 

   }
*/

// 闭包中的弱引用和无主引用
// ①在闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用。
// ②相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。

class HTMElement{
   
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {  // 此闭包和实例一同被销毁，因此使用无主引用
        [unowned self] in
        
        if let text = self.text{
           return "<\(self.name)> \(text) </\(self.name)>"
        }
        else{
           return "</\(self.name)>"
        }
    }
    
    init( name:String, text:String? = nil){
       self.name = name
       self.text = text
    }
    
    deinit{ print("\(name) is being deinitialized") }
}

var html:HTMElement? = HTMElement(name: "p", text: "hello world!")
print("\(html!.asHTML())")  // 无主引用方式捕获self

html = nil // 没有循环强引用，成功释放！














