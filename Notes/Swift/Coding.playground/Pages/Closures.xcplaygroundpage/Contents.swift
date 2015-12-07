///  闭包

// 闭包表达式
var array = [8,2,123,34,234,999,1,4,2,3]
func rising(a:Int, b:Int)->Bool // 降序排序方法
{
    return a > b
}
// 调用降序
array.sort(rising)

// 语法
//{ (parameters) returnType in
//   statement
//}
// 以下代码结果相同
array.sort({(a:Int,b:Int)->Bool in return a > b})  // 完整写法

array.sort({ a, b in return a > b }) // 让闭包自己根据上下文判断参数类型

array.sort({a, b in a > b}) // 省略return

array.sort({$0 > $1}) // 直接使用$取参数并且做对比

array.sort( > ) // 运算符函数


// 尾随闭包
array.sort(){$0 > $1}  // 上例尾随闭包的写法
array.sort{$0 > $1} // 这里的括号可以去掉

// 使用map处理字典内的键值对
let numDict = [0:"zero", 1:"one", 2:"two", 3:"three", 4:"four", 5:"five", 6:"six", 7:"seven", 8:"eight", 9:"nine"]
let numbers = [ 16, 58, 150]
let strings = numbers.map { (var number) -> String in
    var output = ""
    while number > 0
    {
       output = numDict[number % 10]! + output
        number /= 10
    }
    return output
}

print(strings)



