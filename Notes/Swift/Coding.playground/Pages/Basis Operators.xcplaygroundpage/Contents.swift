//: 基础运算符

/// 赋值运算符
// 由于if条件必须是一个bool值，因此赋值操作并不允许 if num = 5

// 字符串拼接
let string = "hello" + "world"

// 浮点数求余
print("\(8 % 2.5)")

/// 空合运算符
// var = a ?? b 
// 相当于 a != nil? a!: b
// 严格限制：1.a必须是optional类型 2.b的值类型必须和a保持一致
var a:Int? = 5
var b = 2,c:Int

c = a ?? b

/// 区间运算符
// a...b 【从a到b（包括b）】，a..<b 【从a到b（不包括b）】
print(5...10)
print(5..<10)


