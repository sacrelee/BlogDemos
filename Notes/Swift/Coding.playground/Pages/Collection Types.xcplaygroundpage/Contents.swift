// 集合类型 Arrays有序，Sets无序无重复，Dictionary键值对 
// 变量即可变，常量不可变


/// 数组
// 初始化
var arr0:[String] = ["hehe"]
var arr1 = [Int]() // 空数组
var arr2 = ["1", "2", "3"] // 字符串
var arr3 = [Double](count: 3, repeatedValue: 9.9) // 重复元素数组
var arr4 = [3.1, 4.4]


// 数组元素相加
var arr5 = arr3 + arr4

// 添加元素
arr1.append(2)
arr2 += ["4"]

// 访问数组个数 同OC
arr4.count

// 访问元素
arr2[0]
arr2.first
arr2.last

// 修改元素
arr2[3] = "hehe"

// 范围内替换
arr2[2...3] = ["hoho"]

// 插入数据
arr2.insert("haha", atIndex: 0)

// 插入数组
arr2.insertContentsOf(["ni","wo","ta"], at: 0)

// 删除元素
arr2.removeAtIndex(0) // 单个
arr2.removeRange(arr2.startIndex..<arr2.startIndex.advancedBy(2)) // 范围内
arr2.removeFirst()
arr2.removeLast()

//遍历
for item in arr2
{
   print(item)
}

for (index, value) in arr2.enumerate()
{
    print("\(index + 1):\(value)")
}

/// 集合
//初始化
// 1.生成空集合，2.集合必须显式声明，因其可能会与数组冲突，3.可以不写集合类型
var letters = Set<Character>()
var words:Set<String> = ["hehe","haha","doubi"]
var numbers:Set = ["one", "two", "three"]

// 重新置空
letters = []

// 访问集合
numbers.count // 元素个数
letters.isEmpty // 是否为空
letters.insert("a")  // 插入数据
numbers.remove("one")  // 删除数据：若存在，返回此值，不存在返回nil
numbers.removeAll()  // 清空
words.contains("doubi")  // 判断是否存在，返回bool值

// 遍历集合元素
// 无序遍历
for aVar in words
{
   print(aVar)
}

// 有序遍历
for bVar in words.sort()
{
   print(bVar)
}

// 两个集合之间的操作
let oddDigits:Set = [1, 3, 5, 7, 9]
let evenDigits:Set = [0, 2, 4, 6, 8]
let primerDigits:Set = [2, 3, 5, 7]

oddDigits.union(evenDigits)  // union 集合的并集
oddDigits.intersect(evenDigits) // intersect 集合的交集
oddDigits.subtract(primerDigits) // subtract “根据不在该集合中的值创建一个新的集合”
oddDigits.exclusiveOr(primerDigits) // subtract 集合的反集

// 判断集合关系
let houseAnimals:Set = ["🐱", "🐶"]
let coutyAnimals:Set = ["🐶", "🐱", "🐮", "🐔", "🐑"]
let farmAnimals:Set = ["🐶", "🐱", "🐮", "🐔", "🐑"]
let cityAnimals:Set = ["🐦", "🐭"]

houseAnimals == farmAnimals // 判断两集合是否相等
coutyAnimals.isSubsetOf(farmAnimals) // 判断是否是后者的子集 (两者允许相等)
coutyAnimals.isStrictSubsetOf(farmAnimals) // 判断是否是后者的真子集 (两者不允许相等)
farmAnimals.isSupersetOf(houseAnimals) // 判断是否是后者的父集 (两者允许相等)
farmAnimals.isStrictSupersetOf(houseAnimals) // 判断是否是后者的真父集 (两者不允许相等)
farmAnimals.isDisjointWith(cityAnimals) // 判断两集合不存在相同值

/// 字典
// 声明
var nameOfIntegers = [Int:String]()
var cityAndCountry0 = ["Beijing": "China"] // 隐式声明
var cityAndCountry1:[String:String] = ["Washington": "USA"]

// 字典操作
cityAndCountry0.count // 键值对个数
nameOfIntegers.isEmpty // 是否为空
nameOfIntegers = [:] // 置空

cityAndCountry0["Beijing"] = "CN" // 根据键修改值
cityAndCountry0["London"] = "England" // 语法与上无异，如果找不到此键，则添加这个键值对

var oldValue = cityAndCountry0.updateValue("UK", forKey: "London") // 根据键修改值，但是返回原值
    oldValue = cityAndCountry0.updateValue("JP", forKey: "Tokyo") // 这里添加了新的键值对，返回值为nil

var nowValue = cityAndCountry0["London"] // 取值

cityAndCountry0["London"] = nil // 移除键值
nowValue = cityAndCountry0.removeValueForKey("Tokyo") // 移除键值并返回被移除的值

// 遍历
for (city, country)in cityAndCountry0  // 键值遍历
{
  print("\(country):\(city)")
}

for key in cityAndCountry0.keys // 遍历键
{
  print("\(key)")
}

for value in cityAndCountry0.values // 遍历值
{
  print("\(value)")
}

// 生成键值的数组
let keyArr = [String](cityAndCountry0.keys) //  把键生成数组
let valueArr = [String](cityAndCountry0.values) // 把值生成数组

