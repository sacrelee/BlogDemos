///  Types 类型

/*   **概述
    Swift 语言存在两种类型：命名型类型和复合型类型。命名型类型是指定义时可以给定名字的类型。命名型类型包括类、结构体、枚举和协议。比如，一个用户定义的类 MyClass 的实例拥有类型 MyClass。除了用户定义的命名型类型，Swift 标准库也定义了很多常用的命名型类型，包括那些表示数组、字典和可选值的类型。

    那些通常被其它语言认为是基本或原始的数据型类型，比如表示数字、字符和字符串的类型，实际上就是命名型类型，这些类型在 Swift 标准库中是使用结构体来定义和实现的。因为它们是命名型类型，因此你可以按照 扩展 和 扩展声明 中讨论的那样，声明一个扩展来增加它们的行为以满足你程序的需求。

    复合型类型是没有名字的类型，它由 Swift 本身定义。Swift 存在两种复合型类型：函数类型和元组类型。一个复合型类型可以包含命名型类型和其它复合型类型。例如，元组类型 (Int, (Int, Int)) 包含两个元素：第一个是命名型类型 Int，第二个是另一个复合型类型 (Int, Int)。
*/

/// 类型注解
// 类型注解显式地指定一个变量或者表达式的值。类型注解始于冒号：终于类型。
let someTuple:( Double, Double) = ( 3.14159, 2.71828 )  // 此类型为( Double, Double)
func someFunction( a:Int ){ /* */}                      // a的类型为 Int

// PS：类型注解可以在类型之前包含一个类型特性（type attributes）的可选列表。


/// 类型标识符
/*  **概述
   类型标识符引用命名型类型或者是命名型/复合型类型的别名。

   大多数情况下，类型标识符引用的是与之同名的命名型类型。例如类型标识符Int引用命名型类型Int，同样，类型标识符Dictionary<String, Int>引用命名型类型Dictionary<String, Int>。
*/

// 在两种情况下类型标识符不引用同名的类型。

// ①类型标识符引用的是命名型/复合型类型的类型别名，
typealias Point = ( Int, Int)    // 类型标识符使用Point来引用元祖( Int, Int)

// ②类型标识符使用dot(.)语法来表示在其它模块（modules）或其它类型嵌套内声明的命名型类型。
var someValue: ErrorType.Type     // 类型标识符引用在ErrorType模块中声明的命名型类型Type


/// 元组类型
/*  **概述
   元组类型使用逗号隔开并使用括号括起来的0个或多个类型组成的列表。

   你可以使用元组类型作为一个函数的返回类型，这样就可以使函数返回多个值。你也可以命名元组类型中的元素，然后用这些名字来引用每个元素的值。元素的名字由一个标识符紧跟一个冒号(:)组成。

   void是空元组类型()的别名。如果括号内只有一个元素，那么该类型就是括号内元素的类型。比如，(Int)的类型是Int而不是(Int)。所以，只有当元组类型包含的元素个数在两个及以上时才可以命名元组元素。
*/


/// 函数类型
/*
    函数类型表示一个函数、方法或闭包的类型，它由一个参数类型和返回值类型组成，中间用箭头->隔开： 'parameter type' -> 'return type'

    ①由于参数类型和返回值类型可以是元组类型，所以函数类型支持多参数与多返回值的函数与方法。

    ②你可以对函数参数使用 autoclosure 特性。这会自动将参数表达式转化为闭包，表达式的结果即闭包返回值。这从语法结构上提供了一种便捷：延迟对表达式的求值，直到其值在函数体中被使用。

    ③函数类型可以拥有一个可变长参数作为参数类型中的最后一个参数。从语法角度上讲，可变长参数由一个基础类型名字紧随三个点（...）组成，如 Int...。可变长参数被认为是一个包含了基础类型元素的数组。即 Int... 就是 [Int]。

    ④为了指定一个 in-out 参数，可以在参数类型前加 inout 前缀。但是你不可以对可变长参数或返回值类型使用 inout。

    ⑤柯里化函数的函数类型从右向左进行组合。例如，函数类型 Int -> Int -> Int 可以理解为 Int -> (Int -> Int)，也就是说，该函数类型的参数为 Int 类型，其返回类型是一个参数类型为 Int，返回类型为 Int 的函数类型。

    ⑥函数类型若要抛出错误就必须使用 throws 关键字来标记，若要重抛错误则必须使用 rethrows 关键字来标记。throws 关键字是函数类型的一部分，非抛出函数是抛出函数函数的一个子类型。因此，在使用抛出函数的地方也可以使用不抛出函数。对于柯里化函数，throws 关键字只应用于最里层的函数。
*/


/// 数组类型
// Swift语言中使用[type]来简化标准库中定义Array<T>类型的操作。
// 下面两个声明是等价的，并且这两种情况下，常量aArray和bArray都被声明为字符串数组。数组的元素也可以通过下标访问：someArray[0] 是指第 0 个元素"Alex"
let aArray:[String] = [ "Alex", "Brian", "Dave"]
let bArray:Array<String> = ["Alex", "Brian", "Dave"]

// 也可以嵌套多对方括号来创建多维数组，最里面的方括号中指明数组元素的基本类型。
var array3D: [[[Int]]] = [[[1, 2], [3, 4]],[[5, 6], [7, 8]]]    // 一个三维数组

// 访问一个多维数组的元素时，最左边的下标指向最外层数组的相应位置元素。接下来往右的下标指向第一层嵌入的相应位置元素，依次类推。这就意味着，在上面的例子中，array3D[0] 是 [[1, 2], [3, 4]]，array3D[0][1] 是 [3, 4]，array3D[0][1][1] 则是 4。


/// 字典类型 
// Swift语言中使用[key type: value type]来简化标准库中定义Dictionary<Key,Value>类型的操作。
/*
   同样的以下两个字典是等价的 
  
   两个常量 aDictionary，bDictionary 均被声明为字典，其中键为 String 类型，值为 Int 类型。

   字典中的值可以通过下标来访问，这个下标在方括号中指明了具体的键：someDictionary["Alex"] 返回键 Alex 对应的值。如果键在字典中不存在的话，则这个下标返回 nil。
*/
let aDictionary:[ String: Int] = [ "Alex": 31, "Paul": 39]
let bDictionary:Dictionary<String, Int> = ["Alex": 31, "Paul": 39]


/// 可选类型
// Swift定义后缀?来作为标准库中的定义的命名型类型Optional<T>的简写。
/*  
    下面两个声明是等价的：
    变量 aInteger,bInteger 均被声明为可选整型类型。注意在类型和 ? 之间没有空格。
*/
var aInteger: Int?
var bInteger: Optional<Int>

/* 类型 Optional<Wrapped> 是一个枚举，有两个成员，None 和 Some(Wrapped)，用来表示可能有也可能没有的值。任意类型都可以被显式地声明（或隐式地转换）为可选类型。如果你在声明或定义可选变量或属性的时候没有提供初始值，它的值则会自动赋为默认值 nil。

   如果一个可选类型的实例包含一个值，那么你就可以使用后缀运算符 ! 来获取该值
*/

aInteger = 56
aInteger!      // 使用！获取值，如果aInteger为nil将会报错
               // 也可以使用可选链式调用和可选绑定来选择性地在可选表达式上执行操作。如果值为 nil，不会执行任何操作，因此也就没有运行错误产生。

/// 隐式解析可选类型

//  Swift语言定义后缀!作为标准库中命名类型ImplicitlyUnwrappedOptional<T>的简写。换句话说，下面两个声明等价：
var aImplicitlyUnwrappedString: String!
var bImplicitlyUnwrappedString: ImplicitlyUnwrappedOptional<String>

/* 上述两种情况下，变量implicitlyUnwrappedString被声明为一个隐式解析可选类型的字符串。注意类型与!之间没有空格。

   你可以在使用可选类型的地方同样使用隐式解析可选类型。比如，你可以将隐式解析可选类型的值赋给变量、常量和可选特性，反之亦然。

   有了可选，你在声明隐式解析可选变量或特性的时候就不用指定初始值，因为它有缺省值nil。

   由于隐式解析可选的值会在使用时自动解析，所以没必要使用操作符!来解析它。也就是说，如果你使用值为nil的隐式解析可选，就会导致运行错误。

   使用可选链会选择性的执行隐式解析可选表达式上的某一个操作。如果值为nil，就不会执行任何操作，因此也不会产生运行错误。
*/

/// 协议合成类型
/*
   协议合成类型是一种遵循具体协议列表中每个协议的类型。协议合成类型可能会用在类型注解和泛型参数中。

   协议合成类型的形式如下：
       protocol<Protocol 1, Procotol 2>

   协议合成类型允许你指定一个值，其类型遵循多个协议的条件且不需要定义一个新的命名型协议来继承其它想要遵循的各个协议。比如，协议合成类型protocol<Protocol A, Protocol B, Protocol C>等效于一个从Protocol A，Protocol B， Protocol C继承而来的新协议Protocol D，很显然这样做有效率的多，甚至不需引入一个新名字。

   协议合成列表中的每项必须是协议名或协议合成类型的类型别名。如果列表为空，它就会指定一个空协议合成列表，这样每个类型都能遵循。
*/

/// 元类型
/*
    元类型是指类型的类型，包括类类型、结构体类型、枚举类型和协议类型。

    类、结构体或枚举类型的元类型是相应的类型名紧跟 .Type。协议类型的元类型——并不是运行时符合该协议的具体类型——而是该协议名字紧跟 .Protocol。比如，类 SomeClass 的元类型就是 SomeClass.Type，协议 SomeProtocol 的元类型就是 SomeProtocal.Protocol。

    使用 .self来获取实例本身，使用.dynamicType来获取实例
*/

class SomeBaseClass {
    class func printClassName(){
        print("someBaseClass")
    }
}

class SomeSubClass:SomeBaseClass {
    override class func printClassName(){
        print("someSubClass")
    }
}

let someInstance: SomeBaseClass = SomeSubClass()  // 编译时为SomeBaseClass，运行时为SomeSubClass
someInstance.dynamicType.printClassName()         // SomeSubClass

// 可以使用恒等运算符( === 和 !== )来测试一个实例运行时类型和编译时类型是否一致
if someInstance.dynamicType === someInstance.self{
   print("The dynamic type of someInstance is SomeBaseClass")
}
else{
    print("The dynamic type of someInstance isn't SomeBaseClass")
}

// 可以使用初始化表达式从某个类型的元类型构造出一个该类型的实例。对于类实例，必须使用 required 关键字标记被调用的构造器，或者使用 final 关键字标记整个类。

class AnotherSubClass: SomeBaseClass {
    let string: String
    required init( string: String ) {
      self.string = string
    }
    
    override class func printClassName(){
       print("AnotherSubClass")
    }
}

let metatype: AnotherSubClass.Type = AnotherSubClass.self
let anotherInstance = metatype.init(string: "some string")

/// 类型继承子句
/* 类型继承子句
    类型继承子句被用来指定一个命名型类型继承自哪个类、采纳哪些协议。类型继承子句也用来指定一个类类型专属协议。类型继承子句开始于冒号 :，其后是类的超类或者一系列类型标识符。

    类可以继承单个超类，采纳任意数量的协议。当定义一个类时，超类的名字必须出现在类型标识符列表首位，然后跟上该类需要采纳的任意数量的协议。如果一个类不是从其它类继承而来，那么列表可以以协议开头。

    其它命名型类型可能只继承或采纳一系列协议。协议类型可以继承自任意数量的其他协议。当一个协议类型继承自其它协议时，其它协议中定义的要求会被整合在一起，然后从当前协议继承的任意类型必须符合所有这些条件。正如在 协议声明 中所讨论的那样，可以把 class 关键字放到协议类型的类型继承子句的首位，这样就可以声明一个类类型专属协议。

    枚举定义中的类型继承子句可以是一系列协议，或是枚举的原始值类型的命名型类型。
*/

///  类型推断

/*
  Swift 广泛使用类型推断，从而允许你省略代码中很多变量和表达式的类型或部分类型。比如，对于 var x: Int = 0，你可以完全省略类型而简写成 var x = 0，编译器会正确推断出 x 的类型 Int。类似的，当完整的类型可以从上下文推断出来时，你也可以省略类型的一部分。比如，如果你写了 let dict: Dictionary = ["A" : 1]，编译器能推断出 dict 的类型是 Dictionary<String, Int>。

  在上面的两个例子中，类型信息从表达式树的叶子节点传向根节点。也就是说，var x: Int = 0 中 x 的类型首先根据 0 的类型进行推断，然后将该类型信息传递到根节点（变量 x）。

  在 Swift 中，类型信息也可以反方向流动——从根节点传向叶子节点。在下面的例子中，常量 eFloat 上的显式类型注解（: Float）将导致数字字面量 2.71828 的类型是 Float 而非 Double。
*/

let e = 2.71828 // e 的类型会被推断为 Double
let eFloat: Float = 2.71828 // eFloat 的类型为 Float

// Swift 中的类型推断在单独的表达式或语句上进行。这意味着所有用于类型推断的信息必须可以从表达式或其某个子表达式的类型检查中获取到。






