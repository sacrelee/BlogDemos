/// 类和结构体

// swift中类和结构体的关系更加密切，以下主要通过实例而不是对象来说明

/* 类与结构体的相同点：
   *定义属性用于存储值
   *定义方法用于提供功能
   *定义附属脚本用于访问值
   *定义构造器用于生成初始化值
   *通过扩展以增加默认实现的功能
   *实现协议以提供某种标准功能”
   
   类另外拥有以下附加功能：
   *继承允许一个类继承另一个类的特征
   *类型转换允许在运行时检查和解释一个类实例的类型
   *解构器允许一个类实例释放任何其所被分配的资源
   *用计数允许对一个类的多次引用

   命名
   为类和结构体使用首字母大写的驼峰命名方式，变量或者方法使用首字母小写的驼峰
*/

/// 定义
class SomeClass{} // 类
struct SomeSturct{} // 结构体

struct Resolution{ // 结构体：像素，拥有宽和高
   var width = 0
   var height = 0
}

class VideoPlayer{  // VideoMode类，拥有各种变量以及方法
    var resolution = Resolution()
    var isFullScreen = false
    var name:String?
    func play(){print("playing")}
    func pause(){print("pause")}
    func stop(){print("stop")}
}

// 创建实例
var reso = Resolution()
let vp = VideoPlayer()

// 访问属性或者方法均通过点语法
reso.width = 1280
reso.height = 720
let width = reso.width

vp.name = "Inception"
let isFull = vp.isFullScreen
vp.pause() // 调用pause方法

// 结构体构造器，
let vga = Resolution(width: 1920, height: 1080)

/// 结构体和枚举是值类型
var fourK = vga
fourK.width = 3840
fourK.height = 2160

// 只是值拷贝，改变fourK并不改变vga中的属性
print("FourK:\(fourK.width)x\(fourK.height); HD:\(vga.width)x\(vga.height)");

// 枚举也是如此,仅仅是值拷贝，
enum Companys{
  case Apple, Google, Amazon, IBM
}
let aCo = Companys.Apple
var bCo = aCo
bCo = .IBM

print("A:\(aCo), B:\(bCo)")

/// 类是引用类型
let aVideoPlayer = vp
aVideoPlayer.name = "insteller"

// 改变aVideoPlayer中属性的同时改变了vp中的属性，类是引用类型
// vp和aVideoPlayer均为常量类型，改变其中属性并不改变常量值
print("aVideoPlayer:\(aVideoPlayer.name),vp:\(vp.name)")

/// 恒等运算符
// 使用"==="表示等价于，"!=="表示不等价于。用于判断是否是引用了的实例
if aVideoPlayer === vp
{
  print("They are equal!")
}

// == 表示值相等 != 表示值不相等

/// 类和结构体之间的选择

/*
  结构体的主要目的是用来封装少量相关简单数据值。
  有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
  任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
  结构体不需要去继承另一个已存在类型的属性或者行为。”
*/

/// 字符串，数组，字典的赋值和复制行为
// swift中这三者均以结构体形式实现，因此均为值拷贝
// Objective C中这三者均以类形式实现，因此均为传递引用


