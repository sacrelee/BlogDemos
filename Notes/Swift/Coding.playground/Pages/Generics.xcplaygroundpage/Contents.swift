/// 泛型 Generics
/*
   泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。
   可以避免重复代码，用清晰和抽象的方式来表达代码意图
*/

/// 泛型所解决的问题

// ①此例为非泛型函数，用来交换两个Int值
func swapTwoInts( inout a:Int, inout _ b:Int){
   let temp = a
   a = b
   b = temp
}

var a = 3, b = 8
swapTwoInts(&a, &b)
print("Now a:\(a), b:\(b)")

// *更多例子
// ②这个函数交换两个字符串的值
func swapTwoStrings( inout a:String, inout _ b:String){
   let temp = a
    a = b
    b = temp
}

// ③这个函数交换两个Double类型值
func swapTwoDoubles( inout a:Double, inout _ b:Double){
   let temp = a
    a = b
    b = temp
}

/*
  以上①②③三个函数，除了传入参数的类型不同，所做的事情是一样的，所以我们需要有一个泛型函数来代替这三个函数

  PS：在所有三个函数中，a和b的类型是一样的。如果a和b不是相同的类型，那它们俩就不能互换值。Swift 是类型安全的语言，所以它不允许一个String类型的变量和一个Double类型的变量互相交换值。如果一定要做，Swift 将报编译错误。
*/

/// 泛型函数

// *以上函数的泛型版本
// <>中的T，是一个占位类型名（一般用T表示），参数后的T表示这两个参数是同一类型
func swapTwoValues<T>( inout a:T, inout _ b:T){
    let temp = a
    a = b
    b = temp
}

var someInt = 3, anotherInt = 10
swapTwoValues( &someInt, &anotherInt)  // 参数为Int型
print("Now someInt: \(someInt), anotherInt: \(anotherInt)")

var aString = "hello", bString = "world"
swapTwoValues( &aString, &bString)   // 参数为String型
print("aString: \(aString), bString: \(bString)")

/// 类型参数
/* ①占位类型T是一种类型参数的示例。
   ②类型参数被指定，就可以作为参数，返回值或者函数主体中的注释类型。函数被调用时，类型参数就会被实际参数类型所替换（在上面swapTwoValues例子中，当函数第一次被调用时，T被Int替换，第二次调用时，被String替换。）
   ③你可支持多个类型参数，命名在尖括号中，用逗号分开。
*/

/// 命名类型参数
/*
  在简单的情况下，泛型函数或泛型类型需要指定一个占位类型（如上面的swapTwoValues泛型函数，或一个存储单一类型的泛型集，如数组），通常用一单个字母T来命名类型参数。不过，你可以使用任何有效的标识符来作为类型参数名。

  如果你使用多个参数定义更复杂的泛型函数或泛型类型，那么使用更多的描述类型参数是非常有用的。例如，Swift 字典（Dictionary）类型有两个类型参数，一个是键，另外一个是值。如果你自己写字典，你或许会定义这两个类型参数为Key和Value，用来记住它们在你的泛型代码中的作用。
  PS:请始终使用大写字母开头的驼峰式命名法（例如T和Key）来给类型参数命名，以表明它们是类型的占位符，而非类型值。
*/

/// 泛型类型
// 通常在泛型函数中，Swift 允许你定义你自己的泛型类型。这些自定义类、结构体和枚举作用于任何类型.

// ①Int类型栈，遵循先进后出的原则
struct IntStack {
    var items = [Int]()
    mutating func push( item:Int){  // push一个元素入栈，（新入栈总是在最后）
       items.append( item)
    }
    
    mutating func pop() -> Int{  // pop一个元素出栈，（总是最后一个）
       return items.removeLast()
    }
}

// ②同上功能的一个泛型版本
struct Stack<T>{          // <>内的泛型参数
   var items = [T]()   // 数组内元素为泛型类型
    mutating func push( item:T){  // push一个泛型元素
       items.append( item)
    }
    
    mutating func pop() -> T{   // pop一个泛型元素
      return items.removeLast()
    }
}

var stackOfString = Stack<String>()  // String类型的栈
stackOfString.push("Google")
stackOfString.push("Apple")
stackOfString.push("Microsoft")
stackOfString.push("IBM")
stackOfString.push("Yahoo")   // push 5个元素

stackOfString.pop()  // pop掉一个元素

/// 扩展一个泛型类型
/*
  当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表。更加方便的是，原始类型定义中声明的类型参数列表在扩展里是可以使用的，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。
*/
extension Stack{
    var topItem:T?{   // 泛型类型"T"可以被直接使用，
        return items.isEmpty ? nil: items[items.count - 1]  // 如果items数组为空，返回空，否则返回最后一个元素
    }
}

if let topItem = stackOfString.topItem {
   print("The top item is: \(stackOfString.topItem)")
}

/// 类型约束
/*
    类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
    
    例如，Swift 的Dictionary类型对作用于其键的类型做了些限制。在字典的描述中，字典的键类型必须是可哈希，也就是说，必须有一种方法可以使其被唯一的表示。这样字典可以唯一确定键。
*/

// *类型约束语法

/*
  你可以写一个在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
      // 这里是函数主体
    }
*/

// *类型约束实例
func findStringIndex( array:[String], _ valueToFind:String ) -> Int?{  // 查找字符串在数组中的位置
    for ( index, value) in array.enumerate(){
        if value == valueToFind {
          return index
        }
    }
    return nil
}

let strings = [ "Dog", "Cat", "Cow", "Pig"]  // 查找Cat
if let index = findStringIndex( strings, "Cat"){
   print("Index of Cat is: \(index)")
}

func findIndex<T:Equatable>( array:[T], _ valueToFind:T ) -> Int? {
    for ( index, value) in array.enumerate(){
        if value == valueToFind {  // 如果T不遵循"Equatable"协议，这里编译不能通过，因为不是所有的传入类型都可以被编译
           return index
        }
    }
    return nil
}

// PS:Equatable协议要求所有遵循此协议的类型均实现 "==" 和 "!=",也就是说可比较的
let doubleIndex = findIndex( [ 3.1415927, 5.45], 2.67)  // 返回结果 nil
let stringIndex = findIndex( ["PU", "TU", "BHU"], "TU") // 返回结果 1

/// 关联类型
/*
  当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。一个关联类型作为协议的一部分，给定了类型的一个占位名（或别名）。作用于关联类型上实际类型在协议被实现前是不需要指定的。关联类型被指定为typealias关键字。
*/

// *关联类型实例
protocol Container{
    
  typealias ItemType
  mutating func append( item:ItemType)  // 可以将元素添加到容器
  var count: Int { get }  // 可以获取当前元素个数
  subscript( i: Int) -> ItemType { get }  // 可以根据下标获取某个元素
    
}

struct StackOfInt:Container {
    
    // IntStack的原始实现
    var items = [Int]()
    mutating func push( item: Int){
       items.append( item)
    }
    mutating func pop() -> Int{
      return items.removeLast()
    }
    
    // 遵循Container协议的实现
    typealias ItemType = Int   // 删掉这一行也没有什么问题
    mutating func append(item: Int) {
        self.push( item)
    }
    
    var count: Int{
       return items.count
    }
    
    subscript( i: Int) -> Int{
      return items[i]
    }
}

// 由于IntStack遵循Container协议的所有要求，只要通过简单的查找append(_:)方法的item参数类型和下标返回的类型，Swift就可以推断出合适的ItemType来使用。
struct StackWithContainer<T>:Container {  // 泛型版本遵循Container协议的栈
    
    var items = [T]()
    mutating func push( item:T){
      items.append(item)
    }
    mutating func pop() -> T{
      return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}


// *扩展一个存在的类型为一指定关联类型

/*
  在扩展中添加协议成员中有描述扩展一个存在的类型添加遵循一个协议。这个类型包含一个关联类型的协议。

  Swift的Array已经提供append(_:)方法，一个count属性和通过下标来查找一个自己的元素。这三个功能都达到Container协议的要求。也就意味着你可以扩展Array去遵循Container协议，只要通过简单声明Array适用于该协议而已。如何实践这样一个空扩展，在通过扩展补充协议声明中有描述这样一个实现一个空扩展的行为：

    extension Array: Container {}

  如同上面的泛型Stack类型一样，Array的append(_:)方法和下标保证Swift可以推断出ItemType所使用的适用的类型。定义了这个扩展后，你可以将任何Array当作Container来使用。
*/

// *Where语句
/* 
  类型约束能够确保类型符合泛型函数或类的定义约束。
*/
extension Array: Container{}

// 这个函数用来判断符合Container协议的两个实例是否相同
func allItemsMatch<C1:Container, C2:Container where C1.ItemType == C2.ItemType, C1.ItemType:Equatable>( someContainer:C1, _ anotherContainer:C2) -> Bool{

    // 检查两个Container的元素个数是否相同
    if someContainer.count != anotherContainer.count {
       return false
    }
    
    // 检查两个Container中相应位置的元素是否相同
    for i in 0..<someContainer.count{
        if someContainer[i] != anotherContainer[i]{
           return false
        }
    }
    
    //  如果以上判断都没问题则返回true
    return true
}

/*
   剖析“<>”中的条件：
  ①C1必须遵循Container协议 (写作 C1: Container)。
  ②C2必须遵循Container协议 (写作 C2: Container)。
  ③C1的ItemType同样是C2的ItemType（写作 C1.ItemType == C2.ItemType）。
  ④C1的ItemType必须遵循Equatable协议 (写作 C1.ItemType: Equatable)。
  
  第三个和第四个要求被定义为一个where语句的一部分，写在关键字where后面，作为函数类型参数链的一部分。

  以上要求的意思是：someContainer是一个C1类型的容器。 anotherContainer是一个C2类型的容器。 someContainer和anotherContainer包含相同的元素类型。 someContainer中的元素可以通过不等于操作(!=)来检查它们是否彼此不同。
  第三个和第四个要求结合起来的意思是anotherContainer中的元素也可以通过 != 操作来检查，因为它们在someContainer中元素确实是相同的类型。
*/

// 判断两个遵循Container协议的实例是否相同
var stackOfStrings = StackWithContainer<String>()
stackOfStrings.push("🐶")
stackOfStrings.push("🐱")
stackOfStrings.push("🐭")
stackOfStrings.push("🐷")

var arrayOfStrings = ["🐶", "🐱", "🐭", "🐷"]

if allItemsMatch(stackOfStrings, arrayOfStrings){
    print("All items match.")
}
else{
    print("Not all items match.")
}








