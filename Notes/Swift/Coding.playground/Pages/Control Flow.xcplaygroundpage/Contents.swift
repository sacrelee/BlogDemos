/// 控制流

/// For循环
for index in 1...10 // 1-10
{
   print("\(index)")
}

for index in 1..<10 // 1-9
{
  print("\(index)")
}

// 如果不需要取到循环次数可以这样
var result = 2
for _ in 1...10
{
  result *= 2
}
print( result)

// 遍历数组
for string in ["ha", "he" ,"dou"]
{
  print("\(string)")
}

// 遍历字典
for (num,string) in [ 1:"one", 2:"two"]
{
  print("\(num):\(string)")
}

// 常规写法
for var num = 0; num < 100; num++ // num的生存期仅在此方法内
    {
     print( num)
    }

/// while循环 repeat-while
// 与其它语言的循环无异 repeat-while相当于do-when


/// 条件语句
// if判断，与OC没什么不同，以下是一个不同
if let var1 = Int("2"), var2 = Int("3") where var1 < var2 // var1，var2 必须是可选值
{
    print("\(var1) < \(var2)")
}

// switch，如果符合多个匹配条件，将只执行第一个匹配到的

//可以多匹配，不需要break
var number = 3
switch(number)
{
  case 1, 3, 5, 7, 9:
    print("\(number) is a odd number")
  case 2, 4, 6, 8, 10:
    print("\(number) is a even number")
  default:
    print("Error")
}

// 区间匹配
switch(number)
{
  case 1...10:
    print("1 < \(number) <= 10")
  case 11..<20:
    print("11 <= \(number) < 20")
  case 20..<30:
    print("20 <= \(number) < 30")
  default:
    print("Error")
}

// 元组匹配
let tuple = ( 1, 1);
switch(tuple)
{
    case ( 0, 0):  // 全匹配
        print("0, 0")
    case ( _, 0):  // 匹配后者
        print("_, 0")
    case ( 0, _):  // 匹配前者
        print("0, _")
    case ( 1...10, -10...10): // 范围匹配
        print("1-10, -10-10")
    default:       // 默认
        print("Error")
}

// 取匹配值
switch(tuple)
{
    case ( 0, 0):  // 全匹配
        print("0, 0")

    case ( let x, 0):  // 匹配后者
        print("\(x), 0")
    case ( 0, let y):  // 匹配前者
        print("0, \(y)")
    case ( 1...10, -10...10): // 范围匹配
        print("1-10, -10-10")
    case let(x, y):  // 这里就是默认了
        print("\(x),\(y)")
//default:       // 默认
//    print("Error")
}

// 加条件判断 where 关键字来进一步添加筛选条件
switch(tuple)
{
    case let(x, y) where x == y: // 当x = y时
        print("x = y")
    case let(x, y) where x < y:
        print("x < y")
    case let(x, y) where x > y:
        print("x > y")
    case let(x, y):
        print("x, y")
}

/// 控制转移
// continue 提前结束本次循环，break终止循环，return终止整个方法，与其它语言无异

// Fallthrough 给switch添加贯穿功能，使其可以继续运行，但是必须要有default分支
switch(number)
{
    case 1...10:
        print("1 < \(number) <= 10")
        fallthrough                  // 添加使其继续匹配分支
    case 11..<20:
        print("11 <= \(number) < 20")
    case 20..<30:
        print("20 <= \(number) < 30")
    default:
        print("Error")
}

// 带标签的语句
var num = 1,sum = 0

loop:while true
{
    
   switch(num,num % 2)
   {
     case let( a, b) where b == 1:
      continue loop
     case let( a, b) where b == 0:
       sum += num
     case let( a, b) where a == 100:
        break loop
     default:
       print("Error")
    }
}

// 控制API在不同版本系统下的执行
if #available (iOS 9, OSX 10.11, *) // 符合此版本执行接下来的部分
{
   print("in iOS 10 or OSX 10.13")
}
else{   // 否则执行以下的
      print("in early Operation System or watchOS")
    }



