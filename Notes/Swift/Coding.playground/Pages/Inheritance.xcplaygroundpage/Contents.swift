/// 继承 Inheritance
// 继承自其它类，称之为子类，被继承的类称之为父类或者超类


/// 一个基类
// 不继承自其他类称之为基类
class Animal{  // 动物基类
    var speed = 0.0
    var name:String{
         return "Animal"
    }
    
    
    func description()->String{ return "Name:\(name), Speed:\(speed)"}
    func eat(){}
}

/// 子类生成

class Felidae:Animal{  // 猫科动物类继承自Animal类
    var numberOfLegs = 4
    var hasTail = true
}

let f = Felidae()
f.speed = 15
print("\(f.description())")


class Cat:Felidae {   // 猫类继承自猫科动物类
    var houseAnimal = true
}

let c = Cat()
c.speed = 10
print("\(c.description())")


/// 重写
// 重写方法 父类方法前加override
// 重写属性 不可以将读写属性重写为只读类型
class Dog:Animal{
    
    var speedLevel = 0
    
    override var name:String{  // 重写属性
       return "Dog"
    }

    override func eat() {   // 重写方法
        print("Dog like eat Bone")
    }
    
    override var speed:Double{   // 重写属性观察器，

        didSet{
           speedLevel = Int(( speed - 10 )) / 10 + 1
        }
    }
}

let aDog = Dog()
aDog.eat()  // 打印Dog like eat Bone
aDog.speed = 40
print("Speed Level:\(aDog.speedLevel)")

print("\(aDog.name)") // 现在name为Dog


///  禁止重写
// 在想要禁止重写的类型前加final 
// 比如：final var, final func, final subscript， 如果试图重写这些，将会报错
// 在final class 表示这个类不能被继承



