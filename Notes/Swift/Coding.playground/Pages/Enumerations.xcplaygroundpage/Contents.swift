// 枚举 Enumerations

/// 实例 
// 这里的值不仅限于整型数，可以是字符串，字符，浮点数或者整型数

enum CompassPoint{ // 分行
    case North
    case South
    case East
    case West
}

enum Companys{  // 写在一行，用逗号隔开
   case Google, Apple, Microsoft, Amazon, IBM
}

print(CompassPoint.East) // 并没有隐式赋值为0-3，这里是"East"

var aCompany = Companys.Google
aCompany = .Apple // 如果此变量已经是Company类型，可以使用"."来快速取值

switch aCompany  // 这里必须考虑到所有枚举,否则无法编译通过
{
 case .Apple:
    print("it's Apple!")
 case .Google:
    print("it's Google!")
 case .Microsoft:
    print("it's Microsoft!")
 case .Amazon:
    print("it's Amazon!")
 case .IBM:
    print("it's IBM!")
}

switch aCompany // 如果只需要匹配某一个，可以使用default
{
  case .Google:
    print("it's Google!")
  default :
    print("it's Others!")
}

/// 相关值

enum BarCode{  // swift 允许枚举内有不同数据类型
   case UPCA(Int, Int, Int, Int)
   case QRCode(String)
}

var aBarCode = BarCode.UPCA( 9, 99999, 99999, 9)
aBarCode = .QRCode("This is a QRCode!")

switch aBarCode // 创建变量或者常量来取值
{
  case .UPCA(let numberSystem, let manufacture, let product, let check):
     print("UPCA:\(numberSystem)-\(manufacture)-\(product)-\(check)")
  case .QRCode(let QRString):
     print("QRCode:\(QRString)")
}

aBarCode = .UPCA( 9, 99999, 99999, 9)
switch aBarCode // 简写，使用一个let或者var来创建
{
    case var .UPCA(numberSystem, manufacture, product, check):
        print("UPCA:\(numberSystem)-\(manufacture)-\(product)-\(check)")
    case var .QRCode(QRString):
        print("QRCode:\(QRString)")
}

/// 原始值
enum ASCIIControlCharacter:Character // 默认设置原始值是字符型并为它们赋值
{
   case Tab = "\t"
   case Return = "\n"
}

enum number:Int // 隐式赋值，后面会被依次赋值为2 3 4......
{
   case one = 1, two, three, four, five, six, seven, eight, nine, ten
}

enum CompanyStrings:String
{
   case Apple, Google, Microsoft
}
let raw = CompanyStrings.Apple.rawValue // 取原始值

let aCompanyString = CompanyStrings(rawValue: "Google") //  这里的构造可能会失败，因为其可能没有这个原始值对应

var comStr = "Apple"
if let aCompany = CompanyStrings(rawValue: comStr) // 通过原始值找到枚举对应
{
   switch aCompany
   {
    case .Apple:
      print("it's Apple!")
   default :
      print("it's Others!")
    }
}
else // 提供的原始值不一定有对应
{
   print("it's isn't a company name")
}

/// 递归枚举
// 使用indirect来标记允许递归
enum numberHandler{  // 这里允许后两个成员可递归
   case number(Int)
   indirect case sum(numberHandler, numberHandler)
   indirect case product(numberHandler, numberHandler)
}

indirect enum allNumberHandler{
   case number(Int)
   case sum( allNumberHandler, allNumberHandler)
   case product( allNumberHandler, allNumberHandler)
}

func computing(num:allNumberHandler)->Int
{
    switch num
    {
      case let .number(value):
       return value
      case let .sum( a, b):
       return computing(a) + computing(b)
      case let .product( a, b):
       return computing(a) * computing(b)
    }
}

// 计算 （2 + 4 ）* 99
let two = allNumberHandler.number(2)
let four = allNumberHandler.number(4)
let sum = allNumberHandler.sum(two, four) // 2 + 4
let product = allNumberHandler.product(sum
    , allNumberHandler.number(99)) // sum * 99
print(computing(product))





