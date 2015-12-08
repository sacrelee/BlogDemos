/// 属性

// 存储属性
struct BookStruct
{
    let bookId:Int
    var bookName:String
}

// 变量结构体图书
var aBook = BookStruct(bookId: 100, bookName: "The Swift")
aBook.bookName = "The Objective C" // 给属性重新赋值
//aBook.bookId = 101   这里会报错因为bookId是常量，
print("\(aBook.bookName)")


// 常量结构体 ,如果结构体被定义为常量，那么它所有的属性都是常量
let bBook = BookStruct(bookId: 200, bookName: "The mist")
//bBook.bookName = "The King"

// 延迟存储属性 
// 变量前加 lazy，当此变量被访问时才会被创建
class Company{
    var name = "a Default Name"
    lazy var description = String()
}
var apple = Company() // name属性已被创建，description属性没有被创建
apple.name = "Apple"
apple.description = "A Design Company" // 才被创建


// 计算属性 setter / getter
struct Point{
   var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point{ //  这样实现getter 和 setter
        get{
           var cp = Point()
            cp.x = origin.x + size.width / 2.0
            cp.y = origin.y + size.height / 2.0
            return cp
        }
        set(newCenter) // 这里传递来的值名为 "newCenter"
        {
           origin.x = newCenter.x - size.width / 2.0
           origin.y = newCenter.y - size.height / 2.0
        }
    }

    var description:String{ // 省去set里面的"newXXX"
        get{
          return self.description
        }
        set{  // 可以直接用newValue来代替"newDescription"
          description = "Description:" + newValue
        }
    }
    
    var readOnly:String{  // 只读属性只实现getter，get可以省略
       return "This is a String ReadOnly!"
    }
}

var r = Rect(origin: Point(x: 99, y: 99), size: Size(width: 100, height: 100))
print(r.center)  // 获取center是计算后的
r.center = Point(x: 70, y: 70)
print(r.origin) // 获取的origin是计算后的

// 属性观察器
class StepCounter{
    var totalStep:Int = 0{
        willSet{  // 属性将要被赋值时
            print("The totalStep will be \(totalStep)");
        }
        didSet{  // 属性已经被赋值时
           if totalStep > oldValue
           {
            print("The totalStep Added \(totalStep - oldValue)")
            }
        }
    }
}

var sc = StepCounter()
sc.totalStep = 100
sc.totalStep = 199

// 全局变量，局部变量
// 全局变量类似于延迟存储属性不过它们之前不需要加lazy， 而局部变量不会被延迟处理
// 可以像处理属性一样的去处理全局/局部变量，


// 类型属性








