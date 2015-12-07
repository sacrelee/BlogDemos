/// 字符串和字符

// 空字符串
var emptyString1 = ""
var emptyString2 = String()

// 判断空
var isEmpty = emptyString1.isEmpty

// 可变字符串
// 拼接字符串
var mutableString = "hello"
mutableString += " world!"

///  字符
var char = "s"
for char1 in mutableString.characters
{
   print(char1)
}

// 字符变量
var char0:Character = "1"

// 字符数组
var chars:[Character] = ["🐶","🐱","🐷"]

// 转换为字符数组
print(String(chars))

/// 可变字符串处理
// 直接拼接字符串
let resultStr1 = emptyString1 + emptyString2

// 拼接字符,append内只能是字符
mutableString.append(char0)

// 取字符串的字符数
print(mutableString.characters.count)

// 取字符串中的某个字符
// 不能用下标简单粗暴的取字符
mutableString[mutableString.startIndex]
mutableString[mutableString.endIndex.predecessor()]
// advancedBy(count) 从某个位置开始的第count个字符
mutableString[mutableString.startIndex.advancedBy(2)]

/// 插入
//  插入字符
mutableString.insert("s", atIndex: mutableString.startIndex)
// 插入字符串.还是必须取字符串才可以
mutableString.insertContentsOf(" I'm Swift!".characters, at: mutableString.endIndex.predecessor())

/// 删除
// 删除字符
mutableString.removeAtIndex(mutableString.startIndex)

// 范围删除
let ran = mutableString.endIndex.advancedBy(-12) ..< mutableString.endIndex
mutableString.removeRange(ran)
print(mutableString)

/// 对比
if emptyString2 == emptyString1
{
   print("\(emptyString2) == \(emptyString1)")
}

if emptyString2 != emptyString1
{
  print("\(emptyString1) != \(emptyString2)")
}

/// 开头与结尾
// 与OC无异
mutableString.hasPrefix("he")
mutableString.hasSuffix("!")


