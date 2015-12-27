/// Access Control 访问控制
/*
  访问控制可以限定其他源文件或模块中代码对你代码的访问级别。这个特性可以让我们隐藏功能实现的一些细节，并且可以明确的申明我们提供给其他人的接口中哪些部分是他们可以访问和使用的。
  你可以明确地给单个类型（类、结构体、枚举）设置访问级别，也可以给这些类型的属性、函数、初始化方法、基本类型、下标索引等设置访问级别。协议也可以被限定在一定的范围内使用，包括协议里的全局常量、变量和函数。
*/

/// 模块和源文件
/*
   **Swift 中的访问控制模型基于模块和源文件这两个概念。
   模块指的是以独立单元构建和发布的Framework或Application。在Swift 中的一个模块可以使用import关键字引入另外一个模块。
   在 Swift 中，Xcode的每个构建目标（比如Framework或app bundle）都被当作模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的Framework，这个Framework在 Swift 中就被称为模块。当它被引入到某个 app 工程或者另外一个Framework时，它里面的一切（属性、函数等）仍然属于这个独立的模块。
  
  源文件指的是 Swift 中的Swift File，就是编写 Swift 源代码的文件，它通常属于一个模块。尽管一般我们将不同的类 分别定义在不同的源文件中，但是同一个源文件可以包含多个类和函数 的定义。
*/

/// 访问级别

/* **概述

   Swift 为代码中的实体提供了三种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
   
   ①public：可以访问自己模块中源文件里的任何实体，别人也可以通过引入该模块来访问源文件里的所有实体。通常情况下，Framework中的某个接口是可以被任何人使用时，你可以将其设置为public级别。
   ②internal：可以访问自己模块中源文件里的任何实体，但是别人不能访问该模块中源文件里的实体。通常情况下，某个接口或Framework作为内部结构使用时，你可以将其设置为internal级别。
   ③private：只能在当前源文件中使用的实体，称为私有实体。使用private级别，可以用作隐藏某些功能的实现细节。

   ④:public为最高级访问级别，private为最低级访问级别。

   PS：注意：Swift中的private访问和其他语言中的private访问不太一样，它的范围限于整个源文件，而不是声明。这就意味着，一个类 可以访问定义该类 的源文件中定义的所有private实体，但是如果一个类 的扩展是定义在独立的源文件中，那么就不能访问这个类 的private成员。
*/

/*  **访问级别的使用原则
   Swift 中的访问级别遵循一个使用原则：访问级别统一性。 比如说：

   一个public访问级别的变量，不能将它的类型定义为internal和private。因为变量可以被任何人访问，但是定义它的类型不可以，所以这样就会出现错误。

   函数的访问级别不能高于它的参数、返回类型的访问级别。因为如果函数定义为public而参数或者返回类型定义为internal或private，就会出现函数可以被任何人访问，但是它的参数和返回类型确不可以，同样会出现错误。
*/

/*  **默认访问级别
   如果你不为代码中的所有实体定义显式访问级别，那么它们默认为internal级别。在大多数情况下，我们不需要设置实体的显式访问级别。因为我们一般都是在开发一个app bundle。
*/

/*  **单目标应用程序访问级别
   当你编写一个单目标应用程序时，该应用的所有功能都是为该应用服务，不需要提供给其他应用或者模块使用，所以我们不需要明确设置访问级别，使用默认的访问级别internal即可。但是如果你愿意，你也可以使用private级别，用于隐藏一些功能的实现细节。
*/

/*  **Framework的访问级别
   当你开发Framework的时候，就需要把一些对外的接口定义为public级别，以便他人导入该Framework后可以正常使用其功能。这些被你定义为public的接口，就是这个Framework的API。

   PS：Framework的内部实现细节依然可以使用默认的internal级别，或者也可以定义为private级别。只有当你想把它作为 API 的一部分的时候，才将其定义为public级别。
*/

/*  **单元测试目标的访问级别
   当你的app有单元测试目标时，测试模块需要能访问到你app中的代码。默认情况下，只有public级别的实体才能被其它模块访问。
   如果在引入生产模块时使用@testable注解，然后带测试的方式编译这个生产模块，单元测试目标就可以访问所有internal级别的实体。
*/

/// 访问控制语法
// 三种级别，public，internal，private

public class SomePublicClass{}         // 一个public类
internal class SomeInternalClass{}     // 一个internal类
private class SomePrivateClass{}       // 一个private类

public var somePublicVariable = 0      // 一个public变量
internal let someInternalConstant = 0  // 一个internal常量
private func somePrivateFunction(){}   // 一个private函数

// 默认访问级别是internal，尽管并没有声明
class aInternalClass{}       // 默认internal访问级别
func aInternalFunction(){}   // 默认


/// 自定义类型
/*
  如果想为一个自定义类型申明显式访问级别，那么要明确一点。那就是你要确保新类型的访问级别和它实际的作用域相匹配。比如说，如果你定义了一个private类，那这个类就只能在定义它的源文件中当作属性类型、函数参数或者返回类型使用。

  类的访问级别也可以影响到类成员（属性、函数、初始化方法等）的默认访问级别。如果你将类申明为private类，那么该类的所有成员的默认访问级别也会成为private。如果你将类申明为public或者internal类（或者不明确的申明访问级别，而使用默认的internal访问级别），那么该类的所有成员的访问级别是internal。

  PS：一个public类的所有成员的访问级别默认为internal级别，而不是public级别。如果你想将某个成员申明为public级别，那么你必须使用修饰符明确的声明该成员。这样做的好处是，在你定义公共接口API的时候，可以明确的选择哪些属性或方法是需要公开的，哪些是内部使用的，可以避免将内部使用的属性方法公开成公共API的错误。
*/

public class PublicClass{  // 显式的public类
    public var publicProperty = 0    // 显式的public类成员
           var interPropery = 0      // 隐式的internal类成员
    private func privateMethod(){}   // 显式的private类成员
}

class InternalClass {
    var internalProperty = 0         // 隐式的internal类成员
    private func privateMethod(){}   // 显式的private类成员
}

private class PrivateClass{
    var privateProperty = 0          // 隐式的private类成员
    func privateMethod(){}           // 隐式的private类成员
}

/* **元组类型

   元组的访问级别使用是所有类型的访问级别使用中最为严谨的。比如说，如果你构建一个包含两种不同类型元素的元组，其中一个元素类型的访问级别为internal，另一个为private级别，那么这个元组的访问级别为private。也就是说元组的访问级别与元组中访问级别最低的类型一致。

   PS：元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推导出的，而不是明确的申明。
*/

/* **函数类型
   函数的访问级别需要根据该函数的参数类型和返回类型的访问级别得出。如果根据参数类型和返回类型得出的函数访问级别不符合默认上下文，那么就需要明确地申明该函数的访问级别。
   
   下面的例子定义了一个名为someFunction全局函数，并且没有明确地申明其访问级别。也许你会认为该函数应该拥有默认的访问级别internal，但事实并非如此。事实上，如果按下面这种写法，代码是无法编译通过的：

    func someFunction() -> (SomeInternalClass, SomePrivateClass) {
       // function implementation goes here
    }

   我们可以看到，这个函数的返回类型是一个元组，该元组中包含两个自定义的类（可查阅自定义类型）。其中一个类的访问级别是internal，另一个的访问级别是private，所以根据元组访问级别的原则，该元组的访问级别是private（元组的访问级别与元组中访问级别最低的类型一致）。

   因为该函数返回类型的访问级别是private，所以你必须使用private修饰符，明确的声明该函数：

    private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    }
  
   将该函数申明为public或internal，或者使用默认的访问级别internal都是错误的，因为如果把该函数当做public或internal级别来使用的话，是无法得到private级别的返回值的.
*/

/* **枚举类型
   枚举中成员的访问级别继承自该枚举，你不能为枚举中的成员单独申明不同的访问级别。
  
   **原始值和关联值

   枚举定义中的任何原始值或关联值的类型都必须有一个访问级别，这个级别至少要不低于枚举的访问级别。比如说，你不能在一个internal访问级别的枚举中定义private级别的原始值类型。
*/
public enum CompassPoint{   // 该枚举访问级别是public，其所有成员的访问级别也是public
   case North
   case South
   case West
   case East
}

/*  **嵌套类型

    如果在private级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有private访问级别。如果在public或者internal级别的类型中定义嵌套类型，那么该嵌套类型自动拥有internal访问级别。如果想让嵌套类型拥有public访问级别，那么需要明确地申明该嵌套类型的访问级别。
*/

/// 子类
//  子类的访问级别不得高于父类的访问级别。比如说，父类的访问级别是internal，子类的访问级别就不能申明为public。
//  此外，在满足子类不高于父类访问级别以及遵循各访问级别作用域（即模块或源文件）的前提下，你可以重写任意类成员（方法、属性、初始化方法、下标索引等）。
public class A{
    private func someMethod(){}  // 此类包含一个private类型方法
}

internal class B:A{
    override internal func someMethod() {}  // 将继承来的private方法重写成internal类型，
}


// 只要满足子类不高于父类访问级别以及遵循各访问级别作用域的前提下（即private的作用域在同一个源文件中，internal的作用域在同一个模块下），我们甚至可以在子类中，用子类成员访问父类成员，哪怕父类成员的访问级别比子类成员的要低：

public class C {
    private func someMethond(){}  // private类型方法
}

internal class D: C {
    override internal func someMethond() {
        super.someMethond()
    }
}

// 因为父类C和子类D定义在同一个源文件中，所以在类B中可以在重写的someMethod方法中调用super.someMethod()。

/// 常量、变量、属性、下标 
/*
  常量、变量、属性不能拥有比它们的类型更高的访问级别。比如说，你定义一个public级别的属性，但是它的类型是private级别的，这是编译器所不允许的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。

  如果常量、变量、属性、下标索引的定义类型是private级别的，那么它们必须要明确的申明访问级别为private：
*/
private var privateInstance = SomePrivateClass()


/*  **Getter和Setter
    常量、变量、属性、下标索引的Getters和Setters的访问级别继承自它们所属成员的访问级别。
    Setter的访问级别可以低于对应的Getter的访问级别，这样就可以控制变量、属性或下标索引的读写权限。在var或subscript定义作用域之前，你可以通过private(set)或internal(set)先为它们的写权限申明一个较低的访问级别。 

    PS：这个规定适用于用作存储的属性或用作计算的属性。即使你不明确地申明存储属性的Getter、Setter，Swift也会隐式的为其创建Getter和Setter，用于对该属性进行读取操作。使用private(set)和internal(set)可以改变Swift隐式创建的Setter的访问级别。这对计算属性也同样适用。
*/

struct TrackedString {   // 此结构体访问级别为默认的internal
    private(set) var numberOfEdits = 0  // set是private级别，
    var value: String = ""{   // 此String类型属性的访问级别为默认的internal
        didSet{
          numberOfEdits++  // 设置value的值时，numberOfEdits就会自增1
        }
    }
}

var ts = TrackedString()
ts.value = "first"
ts.value = "second"
ts.value = "third"
print("number of edits is: \(ts.numberOfEdits)")   // 被赋值过三次，此属性为3

// PS:虽然你可以在其他的源文件中实例化该结构体并且获取到numberOfEdits属性的值，但是你不能对其进行赋值。这样就能很好的告诉使用者，你只管使用，而不需要知道其实现细节。

public struct TrackedStr{
   public private(set) var numberOfEdits = 0   // 此属性的Getter访问级别为public，Setter访问级别为private
    public var value:String = ""{
        didSet{
          numberOfEdits++  // 每赋值一次，自增1
        }
    }
}

/// 初始化
/*  **概述
   我们可以给自定义的初始化方法申明访问级别，但是要不高于它所属类的访问级别。但必要构造器例外，它的访问级别必须和所属类的访问级别相同。

   如同函数或方法参数，初始化方法参数的访问级别也不能低于初始化方法的访问级别。
*/

/* **默认初始化方法
    
    默认初始化方法的访问级别与所属类型的访问级别相同。
    PS：如果一个类型被申明为public级别，那么默认的初始化方法的访问级别为internal。如果你想让无参的初始化方法在其他模块中可以被使用，那么你必须提供一个具有public访问级别的无参初始化方法。
*/

/* **结构体的默认成员初始化方法

   如果结构体中的任一存储属性的访问级别为private，那么它的默认成员初始化方法访问级别就是private。尽管如此，结构体的初始化方法的访问级别依然是internal。

   如果你想在其他模块中使用该结构体的默认成员初始化方法，那么你需要提供一个访问级别为public的默认成员初始化方法。
*/

/// 协议

/*  **概述
    如果想为一个协议明确的申明访问级别，那么需要注意一点，就是你要确保该协议只在你申明的访问级别作用域中使用。

    协议中的每一个必须要实现的函数都具有和该协议相同的访问级别。这样才能确保该协议的使用者可以实现它所提供的函数。

    PS：如果你定义了一个public访问级别的协议，那么实现该协议提供的必要函数也会是public的访问级别。这一点不同于其他类型，比如，public访问级别的其他类型，他们成员的访问级别为internal。
*/

/*  **协议继承

    如果定义了一个新的协议，并且该协议继承了一个已知的协议，那么新协议拥有的访问级别最高也只和被继承协议的访问级别相同。比如说，你不能定义一个public的协议而去继承一个internal的协议。
*/

/*  **协议一致性

     采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。

     如果你采纳了协议，那么实现了协议的所有要求后，你必须确保这些实现的访问级别不能低于协议的访问级别。例如，一个 public 级别的类型，采纳了 internal 级别的协议，那么协议的实现至少也得是 internal 级别。

     PS:Swift 和 Objective-C 一样，协议的一致性是全局的，也就是说，在同一程序中，一个类型不可能用两种不同的方式实现同一个协议。
*/


/// 扩展
/*  **概述
    你可以在访问级别允许的情况下对类、结构体、枚举进行扩展。扩展成员具有和原始类型成员一致的访问级别。例如，你扩展了一个 public 或者 internal 类型，扩展中的成员具有默认的 internal 访问级别，和原始类型中的成员一致 。如果你扩展了一个 private 类型，扩展成员则拥有默认的 private 访问级别。

    或者，你可以明确指定扩展的访问级别（例如，private extension），从而给该扩展中的所有成员指定一个新的默认访问级别。这个新的默认访问级别仍然可以被单独指定的访问级别所覆盖。
*/

/* **通过扩展添加协议一致性

如果你通过扩展来采纳协议，那么你就不能显式指定该扩展的访问级别了。协议拥有相应的访问级别，并会为该扩展中所有协议要求的实现提供默认的访问级别。

*/

/// 泛型
/*  **概述
    泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。
*/

/*  **类型别名

    你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。例如，private 级别的类型别名可以作为 public、internal、private 类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal 或 private 类型的别名。
    
    PS：这条规则也适用于为满足协议一致性而将类型别名用于关联类型的情况。
*/



