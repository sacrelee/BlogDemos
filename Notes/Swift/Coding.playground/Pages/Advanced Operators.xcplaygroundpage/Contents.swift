/// Advanced Operators 高级运算符

/*  **概述

  除了在之前介绍过的基本运算符，Swift 中还有许多可以对数值进行复杂操作的高级运算符。这些高级运算符包含了在 C 和 Objective-C 中已经被大家所熟知的位运算符和移位运算符。

  与C语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符(&+)。所有的这些溢出运算符都是以 & 开头的。

  在定义自有的结构体、类和枚举时，最好也同时为它们提供标准Swift运算符的实现。Swift简化了运算符的自定义实现，也使判断不同类型所对应的行为更为简单。

  我们不用被预定义的运算符所限制。在 Swift 当中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。这些运算符在代码中可以像预设的运算符一样使用，我们甚至可以扩展已有的类型以支持自定义的运算符。
*/


/// 位运算符
/*  **概述

   位运算符(Bitwise operators)可以操作一个数据结构中每个独立的位。它们通常被用在底层开发中，比如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码。
*/

//  **按位取反运算符 ( ~ )
// 可以对一个数值的全部位进行取反。按位取反操作符是一个前置运算符，需要直接放在操作数的之前，并且它们之间不能添加任何空格。

let initialBits: UInt8 = 0b00001111   // 这个常量等于二进制数 00001111，UInt8 类型整数有8个比特位
let invertedBits = ~initialBits       // 这个常量等于initialBits按位取反 11110000


//  **按位与运算符 ( & )
//  按位与运算符(&)可以对两个数的比特位进行合并。
//  只有当两个操作数的对应位都为 1 的时候，该数的对应位才为 1。

let firstSixBits: UInt8 = 0b11111100            // 二进制数 11111100
let lastSixBits: UInt8 = 0b00111111             // 二进制数 00111111
let middFourBits = firstSixBits & lastSixBits   // 二进制数 00111100

//  **按位或运算符 ( | )
//  按位或运算符(|)可以对两个数的比特位进行比较。
//  只要两个操作数的对应位中有任意一个为 1 时，该数的对应位就为 1。

let someBits: UInt8 = 0b10110010          // 二进制数 10110010
let moreBits: UInt8 = 0b01011110          // 二进制数 01011110
let combinedBits = someBits | moreBits    // 二进制数 11111110

//  **按位异或运算符 ( ^ )
//  按位异或运算符(^)可以对两个数的比特位进行比较。
//  当两个操作数的对应位不相同时，该数的对应位就为 1。

let firstBits: UInt8 = 0b00010100            // 二进制数 00010100
let otherBits: UInt8 = 0b00000101            // 二进制数 00000101
let outputBits = firstBits ^ otherBits       // 二进制数 00010001

//  **按位左移( << ) / 右移运算符( >> )
/*
   按位左移运算符( << )和按位右移运算符( >> )可以对一个数进行指定位数的左移和右移，但是需要遵守下面定义的规则:

   对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2
*/

/*  **无符号整型的移位操作
   对无符号整型进行移位的规则如下：

     ①已经存在的比特位按指定的位数进行左移和右移。
     ②任何移动超出整型存储边界的位都会被丢弃。
     ③用 0 来填充移动后产生的空白位。
     ④这种方法称为逻辑移位(logical shift)。
*/

let shiftBits: UInt8 = 0b00000100  // 二进制数 00000100
shiftBits << 1                     // 二进制数 00001000
shiftBits << 2                     // 二进制数 00010000
shiftBits << 5                     // 二进制数 10000000
shiftBits << 6                     // 二进制数 00000000  左移6位，应该是 1,00000000 这里1溢出作废
shiftBits >> 2                     // 二进制数 00000001
shiftBits >> 3                     // 二进制数 00000000  左移3位，应该是 00000000,1 同样的1溢出作废

// 使用移位操作对其他数据类型进行编码和解码
let pink: UInt32 = 0xCC6699
let redComponent = ( pink & 0xFF0000 ) >> 16  // 0xCC6699 & 0xFF0000 = 0xCC0000, 0xCC0000 >> 16 = 0xCC
let greenComponent = ( pink & 0x00FF00 ) >> 8 // 0xCC6699 & 0x00FF00 = 0x006600, 0x006600 >> 8 = 0x66
let blueComponent = pink & 0x0000FF           // 0xCC6699 & 0x0000FF = 0x000099 即 0x99

/*  **有符号整型的移位操作( 这部分最好详细看教程 )

    *当对正整数进行按位右移操作时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
    *这个行为可以确保有符号整数的符号位不会因为右移操作而改变，这通常被称为算术移位(arithmetic shift)。
    *由于正数和负数的特殊存储方式，在对它们进行右移的时候，会使它们越来越接近 0。在移位的过程中保持符号位不变，意味着负整数在接近 0 的过程中会一直保持为负。

    有符号整数使用第 1 个比特位(通常被称为符号位)来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。
    //  00000100   正数  4 在swift中的表示，首位是符号位，0表示正数
    //  11111100   负数 -4 在swift中的表示，首位是符号位，1表示负数。存储的是补码 2^7 - 4 （2的数据位次方-真实值）
*/


/// 溢出运算符
/*  **概述
    在默认情况下，当向一个整数赋超过它容量的值时，Swift 默认会报错，而不是生成一个无效的数。这个行为给我们操作过大或着过小的数的时候提供了额外的安全性。

    然而，也可以选择让系统在数值溢出的时候采取截断操作，而非报错。可以使用 Swift 提供的三个溢出操作符(overflow operators)来让系统支持整数溢出运算。这些操作符都是以 & 开头的：

     溢出加法 &+
     溢出减法 &-
     溢出乘法 &*
*/

var potentailOverFlow = Int16.max
//  potentailOverFlow++   这一行会溢出，必然报错

// **数值溢出

var unsignedOverFlow = UInt8.max          // UInt类型最大值
unsignedOverFlow = unsignedOverFlow &+ 1  // 向上溢出一位，100000000 的结果是 0

unsignedOverFlow = UInt8.min
unsignedOverFlow = unsignedOverFlow &- 1  // 向下溢出一位，结果是 11111111

var signedOverflow = Int8.min             // signedOverflow 等于 Int8 所能容纳的最小整数 -128
signedOverflow = signedOverflow &- 1      // 此时 signedOverflow 等于 127
//  PS: Int8 型整数能容纳的最小值是 -128，以二进制表示即 10000000。当使用溢出减法操作符对其进行减 1 操作时，符号位被翻转，得到二进制数值 01111111，也就是十进制数值的 127，这个值也是 Int8 型整数所能容纳的最大值。


/// 优先级和结合性
/*
   运算符的优先级(precedence)使得一些运算符优先于其他运算符，高优先级的运算符会先被计算。
   结合性(associativity)定义了相同优先级的运算符是如何结合（或关联）的 —— 是与左边结合为一组，还是与右边结合为一组。可以将这意思理解为“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。

   PS : 对于C语言和 Objective-C 来说，Swift 的运算符优先级和结合性规则是更加简洁和可预测的。但是，这也意味着它们于那些基于C的语言不是完全一致的。在对现有的代码进行移植的时候，要注意确保运算符的行为仍然是按照你所想的那样去执行。
*/

2 + 3 * 4 % 5  // 优先级相当于 2 + ((3 * 4) % 5)


/// 运算符函数
//  类和结构可以为现有的操作符提供自定义的实现，这通常被称为运算符重载(overloading)。
struct Vector2D{
    var x = 0.0, y = 0.0
}

//  在这个实现中，输入参数分别被命名为 left 和 right，代表在 + 运算符左边和右边的两个 Vector2D 对象。
func + ( left: Vector2D, right: Vector2D ) -> Vector2D{
   return Vector2D(x: left.x + right.x, y: right.y + right.y )
}

let vector1 = Vector2D(x: 1.0, y: 2.0)
let vector2 = Vector2D(x: 3.0, y: 1.0)
let vector3 = vector1 + vector2  // 现在 + 实现的是刚才重载的功能 ( 4.0, 3.0 )

// 前缀运算符 "-",比如 -a
prefix func - ( vector:Vector2D ) -> Vector2D{
   return Vector2D(x: -vector.x, y: -vector.y )
}

let positive = Vector2D(x: 8.0, y: 4.5)
let negative = -positive       // positive取负值 ( -8.0, -4.5 )
let alsoPositive = -negative   // negative取负值 为正值 ( 8.0, 4.5 )


/// 复合赋值运算符
// 需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
func += ( inout left:Vector2D, right:Vector2D){
    left = left + right   // 这里的+运算符，之前已经定义过，不需要重复定义。
}

var original = Vector2D(x: 3.0, y: 4.5)
let vectorToAdd = Vector2D(x: 1.0, y: 3.4)
original += vectorToAdd    // ( 4.0, 7.9 )

// 后缀运算符 "++",比如 a++
prefix func ++ ( inout vector:Vector2D ) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 2.0, y: 4.1 )
let afterIncrement = ++toIncrement      // afterIncrement 和 toIncrement 均为( 3.0, 5.1 )


/// 等价操作符
// 自定义的类和结构体没有对等价操作符(equivalence operators)进行默认实现，等价操作符通常被称为“相等”操作符(==)与“不等”操作符(!=)。

func == (left: Vector2D, right: Vector2D) -> Bool {     // 判断两个Vector是否相等
   return  left.x == right.x && left.y == right.y
}

func != (left: Vector2D, right: Vector2D) -> Bool {     // 判断两个Vector是否不等
   return left.x != right.x && left.y != right.y
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
   print("These two are equal.")
}

/// 自定义运算符
// 除了实现标准运算符，在 Swift 当中还可以声明和实现自定义运算符(custom operators)。

prefix operator +++ {}  //    自定义运算符 +++
prefix func +++ (inout vector: Vector2D) -> Vector2D {   // 定义一个 +++ 运算符，让传进来的值翻倍
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 2.0, y: 4.0)
let afterDoubling = +++toBeDoubled         // 均为( 4.0, 8.0)


//  **自定义中缀运算符的优先级和结合性

/* 自定义的中缀(infix)运算符也可以指定优先级(precedence)和结合性(associativity)。优先级和结合性中详细阐述了这两个特性是如何对中缀运算符的运算产生影响的。

   结合性(associativity)可取的值有left，right 和 none。当左结合运算符跟其他相同优先级的左结合运算符写在一起时，会跟左边的操作数进行结合。同理，当右结合运算符跟其他相同优先级的右结合运算符写在一起时，会跟右边的操作数进行结合。而非结合运算符不能跟其他相同优先级的运算符写在一起。

   结合性(associativity)的默认值是 none，优先级(precedence)如果没有指定，则默认为 100。
*/

// 以下例子定义了一个新的中缀运算符 +-，此操作符是左结合的，并且它的优先级为 140：
infix operator +- { associativity left precedence 140 }
func +- ( left: Vector2D, right: Vector2D ) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y )
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusminusVector = firstVector +- secondVector    // ( 4.0, -2.0 )

// PS: 当定义前缀与后缀操作符的时候，我们并没有指定优先级。然而，如果对同一个操作数同时使用前缀与后缀操作符，则后缀操作符会先被执行。









