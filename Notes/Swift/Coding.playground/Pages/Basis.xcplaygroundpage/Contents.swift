//: Playground - noun: a place where people can play


/**
*	@author SACRELEE, 2015-11-29 16:11:53
*
*   元组
*/
// 格式：( ValueType1, ValueType2,...)
let httpError = ("NotFound", 404)

// 声明值方法(value1, value2,...) = Tuple
let (statusInfo,statusCode) = httpError

// 取值的方法直接按变量名即可
print("the httpError \(statusInfo),\(statusCode)")

// 给元组中的每个变量命名
let DomainError = (errorInfo:"Domain Error", errorCode:500)

// 通过变量名取到元组中的每个属性
print("the DomainError : \(DomainError.errorInfo),\(DomainError.errorCode)")




/**
*	@author SACRELEE, 2015-11-29 16:11:53
*
*   值缺失
*/
// 在数据类型后面加？来表示这个变量可以为空，
// aString已经被默认赋空值
var aString:String?

// 赋空值
aString = nil

// 有意义的值
aString = "这是一个实在的值"

// 打印
print(aString)


/**
*	@author SACRELEE, 2015-11-29 16:11:53
*
*   可选绑定
*/
// 类似于OC中，如果能够成功赋值，则执行条件内语句
if let num0 = Int("55")
{
   print("The value is \(num0)")
}
else
{
    // else这段取不到if里生成的数据，会报错
   // print("\(num0) is a nil")
}

//可以在if语句中创建变量或常量并且在where中写限定条件
if let num1 = Int("7"), num2 = Int("5") where num1 > num2
{
    print("\(num1) > \(num2)")
}

/// 强制解析
// 如果你能够确定变量中是存在值的，可以在变量名后加！来进行强制解析

var aNumber:Int?

// aNumber中为空，下面这句一定会报错
//print("try to print: \(aNumber!)")

aNumber = 5
if aNumber != nil
{
    // aNumber不为空，运行通过
   print("not a nil Value,it's \(aNumber!)")
}

/// 隐式解析可选类型
// 可选类型
let implic1:String? = "nimeizi"
let implic2:String = implic1!

// 可选类型的隐式解析
let implic3:String! = "nimeizi"
let implic4:String = implic3

if let implic5 = implic3
{
  print("the String is: \(implic5)")
}

/**
*	@author SACRELEE, 2015-11-30 11:11:13
*
*	错误捕捉
*/
// 这函数可能出错
func maybeFaulse() throws
{
  print("会出什么错")
}


//进行错误捕捉
do
{
   try maybeFaulse()
}
catch
{
   print("catch")
}

/**
*	@author SACRELEE, 2015-11-30 14:11:06
*
*	断言
*/

// 当满足断言内的条件时才会执行其内代码
var assertionNumber = 3
assert( assertionNumber<5, "value < 5")



