/// Expressions 表达式
/*
   Swift 中存在四种表达式：前缀表达式，二元表达式，基本表达式和后缀表达式。表达式可以返回一个值，还可以执行某些代码。

   ①前缀表达式和二元表达式就是对某些表达式使用各种运算符。
   ②基本表达式是最短小的表达式，它提供了获取值的一种途径。
   ③后缀表达式则允许你建立复杂的表达式，例如函数调用和成员访问。
*/

/// 前缀表达式
/*
    前缀表达式由可选的前缀运算符和表达式组成。前缀运算符只接收一个参数。

    除了标准库运算符，你也可以对某个变量使用 & 运算符，从而将其传递给函数的输入输出参数。

   前置表达式语法
      前置表达式 → 前置运算符 可选 后置表达式
      前置表达式 → 写入写出(in-out)表达式
      写入写出(in-out)表达式 → & 标识符
*/

/// try操作符
/*
    try表达式由紧跟在可能会出错的表达式后面的try操作符组成，形式如下： try expression 强制的try表示由紧跟在可能会出错的表达式后面的try!操作符组成，出错时会产生一个运行时错误，形式如下：  try! expression

    当在二进制运算符左边的表达式被标记上 try、try? 或者 try! 时，这个操作对整个二进制表达式都产生作用。也就是说，你可以使用圆括号来明确操作符的应用范围。

      sum = try someThrowingFunction() + anotherThrowingFunction()   // try 对两个方法调用都产生作用
      sum = try (someThrowingFunction() + anotherThrowingFunction()) // try 对两个方法调用都产生作用
      sum = (try someThrowingFunction()) + anotherThrowingFunction() // Error: try 只对第一个方法调用产生作用

    try 表达式不能出现在二进制操作符的的右边，除非二进制操作符是赋值操作符或者 try 表达式是被圆括号括起来的。

    try表达式语法
       try 操作符 → try | try­? | try!
*/

/// 二元表达式
/*
    二元表达式由 "左边参数" + "二元运算符" + "右边参数" 组成, 它有如下的形式：

    left-hand argument operator right-hand argument

    注意:在解析时, 一个二元表达式表示为一个一级数组（a flat list）, 这个数组（List）根据运算符的先后顺序，进行进一步组合.例如： 2 + 3 * 5 首先被认为是： 2, + , 3, *, 5. 随后它被转换成 2 + （3 * 5）
*/

/// 赋值表达式
/*
   赋值表达式会对某个给定的表达式赋值。 它有如下的形式；

          expression = value

   就是把右边的 value 赋值给左边的 expression. 如果左边的expression 是一个元组，那么右边必须也是一个具有同样数量参数的元组.

      (a, _, (b, c)) = ("test", 9.45, (12, 3))  // a 为 "test"，b 为 12，c 为 3，9.45 会被忽略
   
   赋值运算符不返回任何值”
*/

/// 三元条件运算符

 /*
     三元条件运算符会根据条件来对两个给定表达式中的一个进行求值，形式如下：

        条件 ? 表达式（条件为真则使用） : 表达式（条件为假则使用）

     如果条件为真，那么对第一个表达式进行求值并返回结果。否则，对第二个表达式进行求值并返回结果。未使用的表达式不会进行求值。
*/

///  类型转换运算符

/*
   有 4 种类型转换运算符：is、as、?和!。它们有如下的形式：

     表达式 is 类型
     表达式 as 类型
     表达式 is? 类型
     表达式 as! 类型

   is 运算符在运行时检查表达式能否向下转化为指定的类型，如果可以则返回 ture，否则返回 false。

   as 运算符在编译时执行向上转换和桥接。向上转换可将表达式转换成超类的实例而无需使用任何中间变量。以下表达式是等价的：
*/

func f( any: Any){ print("Function for Any.") }
func f( int: Int){ print("Function for Int.") }

let x = 10
f( x )         // print "Function for Int."

let y: Any = x
f( y )         // print "Function for Any."

f( x as Any)   // print "Function for Any."

/*
   桥接可将 Swift 标准库中的类型（例如 String）作为一个与之相关的 Foundation 类型（例如 NSString）来使用，而不需要新建一个实例。关于桥接的更多信息，请参阅 Using Swift with Cocoa and Objective-C 中的 Working with Cocoa Data Types。

   as? 运算符有条件地执行类型转换，返回目标类型的可选值。在运行时，如果转换成功，返回的可选值将包含转换后的值，否则返回 nil。如果在编译时就能确定转换一定会成功或是失败，则会编译出错。

   as! 运算符执行强制类型转换，返回目标类型的非可选值。如果转换失败，则会导致运行时错误。表达式 x as T 效果等同于 (x as? T)!。
*/


/// 基本表达式
// 基本表达式是最基本的表达式。 它们可以跟前缀表达式、二元表达式、后缀表达式以及其他基本表达式组合使用。

/*  **字面量表达式

     字面量表达式可由普通字面量（例如字符串或者数字），字典或者数组字面量，或者下面列表中的特殊字面量组成：

        字面量	          类型	     值
        __FILE__	     String	    所在的文件名
        __LINE__	     Int	    所在的行数
        __COLUMN__	     Int	    所在的列数
        __FUNCTION__	 String	    所在的声明的名字

      对于 __FUNCTION__，在函数中会返回当前函数的名字，在方法中会返回当前方法的名字，在属性的存取器中会返回属性的名字，在特殊的成员如 init 或 subscript 中会返回这个关键字的名字，在某个文件中会返回当前模块的名字。

      __FUNCTION__ 作为函数或者方法的默认参数值时，该字面量的值取决于函数或方法调用时所处的环境。
*/
func logFunctionName( string: String = __FUNCTION__ ){
   print( string )
}

func aTestFuction(){
  logFunctionName()
}

aTestFuction() // print "aTestFunction"

/*
    数组字面量是值的有序集合，形式如下：

      [值 1, 值 2, ...]

    数组中的最后一个表达式可以紧跟一个逗号。数组字面量的类型是 [T]，这个 T 就是数组中元素的类型。如果数组中包含多种类型，T 则是跟这些类型最接近的的公共父类型。空数组字面量由一组方括号定义，可用来创建特定类型的空数组。
*/
var emptyArray: [Double] = [ ]

/*
   字典字面量是一个包含无序键值对的集合，形式如下：

     [键 1 : 值 1, 键 2 : 值 2, ...]

   字典中的最后一个表达式可以紧跟一个逗号。字典字面量的类型是 [Key : Value]，Key 表示键的类型，Value 表示值的类型。如果字典中包含多种类型，那么 Key 表示的类型则为所有键最接近的公共父类型，Value 也是同样如此。一个空的字典字面量由方括号中加一个冒号组成（[:]），从而与空数组字面量区分开，可以使用空字典字面量来创建特定类型的字典.
*/
var emptyDictionary: [String: Double] = [ : ]

/*  **字面量表达式语法

  字面量表达式 → 字面量
  字面量表达式 → 数组字面量 | 字典字面量
  字面量表达式 → __FILE__ | __LINE__ | __COLUMN__ | __FUNCTION__

  数组字面量 → [ 数组字面量项列表可选 ]
  数组字面量项列表 → 数组字面量项 ,可选 | 数组字面量项 , 数组字面量项列表
  数组字面量项 → 表达式

  字典字面量 → [ 字典字面量项列表 ] | [ : ]
  字典字面量项列表 → 字典字面量项 ,可选 | 字典字面量项 , 字典字面量项列表
  字典字面量项 → 表达式 : 表达式
*/

/*  **self 表达式

    self 表达式是对当前类型或者当前实例的显式引用，它有如下形式：

        self
        self.成员名称
        self[下标索引]
        self(构造器参数)
        self.init(构造器参数)

    如果在构造器、下标、实例方法中，self 引用的是当前类型的实例。在一个类型方法中，self 引用的是当前的类型。
*/

    class SomeClass {
        var greeting: String
        init( greeting:String){
           self.greeting = greeting   // 用来区分重名变量
        }
    }

    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy( deltaX: Double, deltaY: Double){
           self = Point( x: x + deltaX, y: y + deltaY )        // 对self重新赋值
        }
    }
/* self表达式语法
        self 表达式 → self
        self 表达式 → self . 标识符
        self 表达式 → self [ 表达式 ]
        self 表达式 → self . init
*/

/*  **超类表达式
  超类表达式可以使我们在某个类中访问它的超类，它有如下形式：

    super.成员名称
    super[下标索引]
    super.init(构造器参数)

  第一种形式用来访问超类的某个成员，第二种形式用来访问超类的下标，第三种形式用来访问超类的构造器。

  子类可以通过超类表达式在它们的成员、下标和构造器中使用超类中的实现。

  超类表达式语法

    超类表达式 → 超类方法表达式 | 超类下标表达式 | 超类构造器表达式
    超类方法表达式 → super . 标识符
    超类下标表达式 → super [ 表达式 ]
    超类构造器表达式 → super . init
*/

/*   **闭包表达式

    闭包表达式会创建一个闭包，在其他语言中也叫匿名函数。跟函数一样，闭包包含了待执行的代码，不同的是闭包还会捕获所在环境中的常量和变量。它的形式如下：

        { (parameters) -> return type in
             statements
        }

    闭包的参数声明形式跟函数一样。闭包还有几种特殊的形式，能让闭包使用起来更加简洁：

        ①闭包可以省略它的参数和返回值的类型。如果省略了参数名和参数类型，也要省略 in 关键字。如果被省略的类型无法被编译器推断，那么就会导致编译错误。

        ②闭包可以省略参数名，参数会被隐式命名为 $ 跟上其索引位置，例如 $0、$1、$2 分别表示第一个、第二个、第三个参数，以此类推。

        ③如果闭包中只包含一个表达式，那么该表达式的结果就会自动成为闭包的返回值。表达式结果的类型也会被推断为闭包的返回类型。

    以下三个闭包是相同的：

        myFunction {
        (x: Int, y: Int) -> Int in
        return x + y
        }

        myFunction {
        (x, y) in
        return x + y
        }

        myFunction { return $0 + $1 }

        myFunction { $0 + $1 }
*/

/*  捕获列表

    默认情况下，闭包会通过强引用捕获所在环境中的常量和变量。你可以通过一个捕获列表来显式指定它的捕获行为。

    捕获列表在参数列表之前，由中括号括起来，里面是由逗号分隔的一系列表达式。一旦使用了捕获列表，就必须使用 in 关键字，即使省略了参数名、参数类型、返回类型。

    捕获列表中的条目会在闭包创建时被初始化。每一个条目都会被闭包所在环境中的同名常量或者变量初始化。例如下面的代码示例中，捕获列表包含 a 而不包含 b，这将导致这两个变量具有不同的行为。
*/

    var a = 0
    var b = 0
    let closure = { [a] in
        print( a, b )
    }
    a = 10
    b = 10

    closure()   // 0, 10
/*
   上例中，变量 b 只有一个，然而，变量 a 有两个，一个在闭包外，一个在闭包内。闭包内的变量 a 会在闭包创建时用闭包外的变量 a 的值来初始化，除此之外它们并无其他联系。这意味着在闭包创建后，改变某个 a 的值都不会对另一个 a 的值造成任何影响。与此相反，闭包内外都是同一个变量 b，因此在闭包外改变其值，闭包内的值也会受影响。
*/

/*
  如果闭包捕获的值是引用语义，则又会有所不同。例如，下面示例中，有两个变量 x，一个在闭包外，一个在闭包内，由于它们的值是引用语义，虽然这是两个不同的变量，它们却都引用着同一实例。
*/
class SimpleClass {
    var value: Int = 0
}

let c = SimpleClass()
let d = SimpleClass()

let closure0 = { [ c ] in
   print( c.value, d.value )
}
c.value = 10
d.value = 10
closure0()  // 10, 10

/*
   如果捕获列表中的值是类类型，你可以使用 weak 或者 unowned 来修饰它，闭包会分别用弱引用和无主引用来捕获该值。

    myFunction { print(self.title) }                   // 以强引用捕获
    myFunction { [weak self] in print(self!.title) }   // 以弱引用捕获
    myFunction { [unowned self] in print(self.title) } // 以无主引用捕获

   在捕获列表中，也可以使用任意表达式来赋值。该表达式会在闭包被创建时进行求值，闭包会按照指定的引用类型来捕获表达式的值。例如：
   // 以弱引用捕获 self.parent 并赋值给 parent
   myFunction { [weak parent = self.parent] in print(parent!.title) }
*/


/* **隐式成员表达式

   在可以判断出类型的上下文中，隐式成员表达式是访问某个类型的成员（例如某个枚举成员或某个类型方法）的简洁方法，形式如下：

     .成员名称

   例如：
        var x = MyEnumeration.SomeValue
            x = .AnotherValue
*/

/*   **圆括号表达式

      圆括号表达式由多个逗号分隔的子表达式组成。每个子表达式前面可以有一个标识符，用冒号隔开，其形式如下：

        (标识符 1 : 表达式 1, 标识符 2 : 表达式 2, ...)

      使用圆括号表达式来创建元组，然后将其作为参数传递给函数。如果某个圆括号表达式中只有一个子表达式，那么它的类型就是子表达式的类型。例如，表达式 (1) 的类型是 Int，而不是 (Int)。
*/

/*  **通配符表达式

      通配符表达式用来忽略传递进来的某个参数。例如，下面的代码中，10 被传递给 x，20 被忽略：

          (x, _) = (10, 20)
          // x 为 10，20 被忽略
*/

/// 后缀表达式
// 后缀表达式就是在某个表达式的后面加上后缀运算符。严格地讲，每个基本表达式也是一个后缀表达式。

/*  **函数调用表达式

   函数调用表达式由函数名和参数列表组成，形式如下：

       函数名(参数 1, 参数 2)

   函数名可以是值为函数类型的任意表达式。

   如果函数声明中指定了参数的名字，那么在调用的时候也必须得写出来。这种函数调用表达式具有以下形式：

       函数名(参数名 1: 参数 1, 参数名 2: 参数 2)

   如果函数的最后一个参数是函数类型，可以在函数调用表达式的尾部（右圆括号之后）加上一个闭包，该闭包会作为函数的最后一个参数。如下两种写法是等价的：

        // someFunction 接受整数和闭包参数
        someFunction(x, f: {$0 == 13})
        someFunction(x) {$0 == 13}

   如果闭包是该函数的唯一参数，那么圆括号可以省略。

        // someFunction 只接受一个闭包参数
        myData.someMethod() {$0 == 13}
        myData.someMethod {$0 == 13}
*/

/*  **构造器表达式

  构造器表达式用于访问某个类型的构造器，形式如下：

    表达式.init(构造器参数)

  你可以在函数调用表达式中使用构造器表达式来初始化某个类型的新实例。也可以使用构造器表达式来代理到超类的构造器。

        class SomeSubClass: SomeSuperClass {
           init() {
               // 此处为子类构造过程
              super.init()
           }
        }
*/

//  和函数类似，构造器表达式可以作为一个值。 例如：
let initializer: Int -> String = String.init
let oneTwoThree = [ 1, 2, 3].map(initializer).reduce( "", combine: + )
print(oneTwoThree)   // 123

/*
    如果通过名字来指定某个类型，可以不用构造器表达式而直接使用类型的构造器。在其他情况下，你必须使用构造器表达式。

        let s1 = SomeType.init(data: 3) // 有效
        let s2 = SomeType(data: 1)      // 有效

        let s4 = someValue.dynamicType(data: 5)      // 错误
        let s3 = someValue.dynamicType.init(data: 7) // 有效
*/

/*  **显式成员表达式

     显式成员表达式允许我们访问命名类型、元组或者模块的成员，形式如下：

       表达式.成员名
*/

    // 命名类型的某个成员在原始实现或者扩展中定义，例如：

        class aClass {
             var someProperty = 42
        }
        let e = aClass()
        let f = e.someProperty // 访问成员

    // 元组的成员会根据表示它们出现顺序的整数来隐式命名，以 0 开始，例如：

     var t = (10, 20, 30)
      t.0 = t.1
    // 现在元组 t 为 (20, 20, 30)

// 对于模块的成员来说，只能直接访问顶级声明中的成员。


/*    **后缀 self 表达式

   后缀 self 表达式由某个表达式紧跟 .self 组成，形式如下：

      表达式.self
      类型.self

   第一种形式返回表达式的值。例如：x.self 返回 x。

   第二种形式返回表示对应类型的值。我们可以用它来动态地获取某个实例的类型。例如，SomeClass.self 会返回 SomeClass 类型本身，你可以将其传递给相应函数或者方法作为参数。

*/


/*   **dynamicType 表达式

   dynamicType 表达式由某个表达式紧跟 .dynamicType 组成，形式如下：

      表达式.dynamicType
*/
    class SomeBaseClass {
        class func printClassName(){
           print("SomeBaseClass")
        }
    }

    class SomeSubClass: SomeBaseClass {
        override class func printClassName(){
           print("SomeSubClass")
        }
    }

    let someInstance: SomeBaseClass = SomeSubClass()
    // 编译时为SomeBaseClass
    // 运行时为SomeSubClass
    someInstance.dynamicType.printClassName()   // 打印 SomeSubClass

/*   **下标表达式

  可通过下标表达式访问相应的下标，形式如下：

     表达式[索引表达式]

  要获取下标表达式的值，可将索引表达式作为下标表达式的参数，调用表达式类型的下标 getter。下标 setter 的调用方式与之一样。
*/


/*   **强制取值表达式

    当你确定可选值不是 nil 时，可以使用强制取值表达式来强制解包，形式如下：

       表达式!

    如果该表达式的值不是 nil，则返回解包后的值。否则，抛出运行时错误。
*/

   // 返回的值可以被修改，无论是修改值本身，还是修改值的成员。例如：
      var h: Int? = 0
       h!++           // h = 1

      var someDictionary = [ "a": [1, 2, 3], "b": [ 10, 20 ]]
      someDictionary["a"]![0] = 100    // now [ "a": [ 100, 2, 3 ], "b": [ 10, 20 ]]

/*   **可选链表达式

     可选链表达式提供了一种使用可选值的便捷方法，形式如下：

       表达式?

     后缀 ? 根据表达式生成可选链表达式，而不会改变表达式的值。

     如果某个后缀表达式包含可选链表达式，那么它的执行过程会比较特殊。如果该可选链表达式的值是 nil，整个后缀表达式会直接返回 nil。如果该可选链表达式的值不是 nil，则返回可选链表达式解包后的值，并用于后缀表达式中剩余的表达式。在这两种情况下，整个后缀表达式的值都会是可选类型。

     如果某个后缀表达式中包含了可选链表达式，那么只有最外层的表达式会返回一个可选类型。例如，在下面的例子中，如果 c 不是 nil，那么它的值会被解包，然后通过 .property 访问它的属性，接着进一步通过 .performAction() 调用相应方法。整个 c?.property.performAction() 表达式返回一个可选类型的值。

            var c: SomeClass?
            var result: Bool? = c?.property.performAction()

     上面的例子跟下面的不使用可选链表达式的例子等价：

            var result: Bool? = nil
            if let unwrappedC = c {
               result = unwrappedC.property.performAction()
            }
*/

 // 可选链表达式解包后的值可以被修改，无论是修改值本身，还是修改值的成员。如果可选链表达式的值为 nil，则表达式右侧的赋值操作不会被执行。
    func someFunctionWithSideEffects() -> Int {
        print("someFucntionWithSideEffects")
        return 42
    }
    var aDictionary = [ "a": [ 1, 2, 3], "b": [ 10, 20 ]]
    aDictionary["not here"]?[0] = someFunctionWithSideEffects()   // 字典并没有被修改，此函数也未执行
    aDictionary["a"]?[0] = someFunctionWithSideEffects()          // [ "a": [ 42, 2, 3 ], "b": [ 10, 20 ]]








