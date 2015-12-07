/// 函数

// func 函数名(参数一:类型,...,)->返回值类型{ 函数体 }

/// 参数和返回值
// 单一参数
func printHello(name:String)->String
{
    return "hello "+name+"!"
}
printHello("little boy")

// 多个参数
func average(num1:Int, num2:Int, num3:Int) ->Double
{
  return (Double)(num1 + num2 + num3 )/3
}
average( 3, num2: 7, num3: 13)

// 无参
func nullParameters()->String
{
  return "Hello world!"
}
print(nullParameters())

// 不同类型的多种函数
func getDigits( isOdd:Bool,numbers:[Int])->[Int]
{
     var result = [Int]()
    
    for tmpNum in numbers
    {
       if ( tmpNum % 2 == 0 ) == isOdd
       {
         result.append( tmpNum)
       }
    }
   return result
}
print( getDigits( false, numbers: [1,2,3,4,5,6]))

// 返回值，可以被忽略
// 无返回值
func nullReturn()
{
   print("with my JJ thing?")
}

// 多重返回值,计算数组的最大、最小和平均值
// 为了处理空数组的情况，这里设置返回值可以为空
func handleDigits( digits:[Int])->(max:Int, min:Int, average:Double)?
{
    if digits.isEmpty{ return nil}
    
    var ma = digits[0],mi = digits[0], sum = 0
    
    for integer in digits
    {
        sum += integer
        
       if integer > ma // 最大值
       {
         ma = integer
        }
        
        if integer < mi // 最小值
        {
           mi = integer
        }
    }
    return (ma, mi, Double(sum/digits.count))
}

// 参数名称,第一个参数名不被显示，后面的会
getDigits( true, numbers: [1,2,4,5,0,14])

// 外部参数名
func printInfo( errorCode code:Int, errorMessage msg:String)
{
  print("\(code):\(msg)")
}

// 将会全部显示外部参数名，第一个也会显示
printInfo(errorCode: 404, errorMessage: "Not Found")

// 省略后部参数名: 使用 "_"
func printInfoWithoutName( errorCode:Int, _ msg:String)
{
  print("\(errorCode):\(msg)")
}


// 默认参数值
func printInfoWithDefaultInfo( errorCode:Int = 404, errorMessage:String = "Not Found")
{
   print("\(errorCode):\(errorMessage)")
}
printInfoWithDefaultInfo()
printInfoWithDefaultInfo( 200, errorMessage: "normal")

// 可变参数,需要都是同类型
func average(numbers:Double...)->Double
{
    var sum:Double = 0
    var i = 1
    for num in numbers
    {
       sum += num
       i++
    }
   return sum/Double(i)
}
average(1,2,3,4,23,56,79)

// 变量参数
func sum(var num:Int, count:Int)->Int
{
   for _ in 0..<count
   {
     num+=num;
    }
    return num
}
sum( 10, count: 10)

// 输入输出参数,传入的变量将被改变，类似指针参数
func exchange(inout num0:Int, inout num1:Int)
{
   let tmp = num0
    num0 = num1
    num1 = tmp
}
var a = 3, b = 4
print("\(a),\(b)")
exchange(&a, num1: &b)
print("\(a),\(b)")

// 函数类型
func addTwoInts( num1:Int, num2:Int)->Int
{
   return num1 + num2
}

func multiplyTwoInts( num1:Int, num2:Int)->Int
{
   return num1 * num2
}

// mathFunction和addTwoInt功能一样
var mathFunction:(Int, Int)->Int = addTwoInts
print(mathFunction(2, 4))
// 现在mathFunctioin和multiply功能一样
mathFunction = multiplyTwoInts
print(mathFunction(2, 4))

// 这个函数把函数作为一个参数
func printResult( function:(Int, Int)->Int, _ a:Int, _ b:Int)->Int
{
   let result = function( a, b)
   print("the result is:\(result)")
   return result
}
// 计算结果根据传进去的函数所得
printResult( addTwoInts, 4, 5)
printResult( multiplyTwoInts, 4, 5)

// 函数类型作为返回值
func chooseFunction(isAdd:Bool)->(Int, Int)->Int
{
    return isAdd ? addTwoInts : multiplyTwoInts
}
// 根据返回的函数类型
let function0:(Int, Int)->Int = chooseFunction(false)
function0(5, 6)

// 函数嵌套
func chooseFunc( isAdd:Bool)->(inout Int,inout Int)->Int
{
    func add(inout a: Int, inout b: Int)->Int{ a++;b++; return a + b }
    func multiply(inout a: Int, inout b: Int)->Int{ a++;b++; return a * b }
    return isAdd ? add: multiply
}
let f = chooseFunc(true)
var num0 = 3, num1 = 5
f(&num0,&num1)

