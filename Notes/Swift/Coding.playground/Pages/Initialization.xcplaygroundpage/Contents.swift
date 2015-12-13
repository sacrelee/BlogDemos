///  构造过程
// 构造过程是使用类，结构体，枚举等的一个准备过程，
// 通过构造器可以生成不同的特殊的实例，swift中的构造器没有返回值，主要是对实例进行初始化

/// 设置存储型属性的初始值

// 构造器,默认属性值
struct  Car{
    
    var name = "little Car😛"  //  这是一个默认属性值，如果它一般不被改变，比起写在init中，这种方式更好
    
    var speed:Double
    init(){  // 构造器，给属性赋初值
       speed = 10
    }
}

let s = Car.init()
print("\(s.name): \(s.speed)")

// 自定义构造过程
struct SpeedBySecond{

    var meterPerSec:Double
    init(meterPerSec mps:Double)  // 构造参数
    {
       meterPerSec = mps
    }
    
    init(kilometerPerHour kmph:Double)
    {
       meterPerSec = kmph / 3.6
    }
    func description()->String
    {
       return "The Speed is: \(meterPerSec) m/s"
    }
}

var sbs = SpeedBySecond.init(kilometerPerHour: 720)
print("\(sbs.description())")
sbs = SpeedBySecond.init(meterPerSec: 17)
print("\(sbs.description())")

// 参数的内部名称和外部名称，可选属性类型
struct Color{

    let r, g, b:Double
    var name:String?  // 可选属性类型，默认在初始化时为nil
    
    init(Red r:Double, Green g:Double, Bule b:Double)
    {
       self.r = r
       self.g = g
       self.b = b
    }
    
    init( _ w:Double) // 不带外部参数名，使用"_"代替外部参数名
    {
       r = w
       g = w
       b = w
    }
}

var c = Color.init(Red: 1.0, Green: 0.4, Bule: 0.5)  // 带外部参数名的构造方法必须这么写，否则会报错
c = Color.init(0.9)  // 这个构造方法不带参数名

print("\(c.name)") // 可选属性是空的
c.name = "Color"

// 常量属性的修改
// 可以在构造过程的任何时候修改常量属性，一旦结束构造过程就不能被修改
// 常量属性只能在自身类的构造过程中修改，不能被子类修改

struct Name {
    let n:String
    init(){
      n = "this is a name!"
    }
}

/// 默认构造器
// 没有自定义构造器的情况下会自动创建一个构造器,按照属性的默认值创造一个实例
class Student{
    var name = "Student"
    var score = 100
    var sex = true
    var birth:String?
}

var stu = Student()
print("\(stu.name), \(stu.score), \(stu.sex), \(stu.birth)")


/// 逐一成员的构造器
// 存储型属性提供了默认值，但是没有自定义构造，会获得一个逐一成员构造器
struct Size{
    var width, height:Double
    var description:String?
}

let si = Size(width: 1.2, height: 3.3, description: nil)

/// 值类型的构造器代理
// 通过调用其它构造器来完成构造过程称之为构造器代理，可以减少代码重复
struct Seconds{
    
    var sum:Int = 0
    var description:String = ""
    
    init(){}
    init(minutes m:Int){
        self.init(seconds:m * 60)
    }
    
    init(seconds s:Int){
      sum = s
       description = "\(sum)s."
    }
}

var sec = Seconds.init(minutes: 5)
print("\(sec.description)")

sec = Seconds.init(seconds: 79)
print("\(sec.description)")




