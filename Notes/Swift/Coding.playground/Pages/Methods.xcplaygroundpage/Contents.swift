///  方法
// 实例方法和类型方法 分别相当于OC中的"-方法"和"+方法"
// 方法同样有局部参数名和外部参数名

// 实例方法（OC中的 -方法）
// 由特定的类、结构体、枚举的具体实例所定义的方法，来实现对应的实例任务和功能


class Computing {
    var num1 = 0
    var num2 = 0
    
    func sumWith( num3:Int)->Int{

      return num1 + num2 + num3
    }
    
    func sumWithArray(numbers num3:Int, _ num4:Int, _ num5:Int)->Int // 同函数，支持后续省略的外部名称以"_"代替
    {
       return num1 + num2 + num3 + num4 + num5
    }
    
    func averageWith(aNumber num3:Int)->Double{ // 同函数，方法同样可有外部参数名
      return Double( num1 + num2 + num3) / 3.0
    }
    
}

var aCom = Computing()
aCom.num1 = 59
aCom.num2 = 79
aCom.sumWith(90)
aCom.sumWithArray(numbers: 1, 2, 3)
aCom.averageWith(aNumber:103)

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}


/// self属性
// 和OC中类似，是一个隐藏属性，代表实例本身
struct Counter{
    var count = 50
    
    func compare(count:Int) -> Bool{  // 使用self.count 消除歧义
      return self.count > count
    }
    
    // 结构体和枚举中的属性是值类型，默认不允许在实例方法中被修改
    // 通过在方法前加 "mutating"（变异）来修改结构体或者枚举中的属性
    mutating func reset(){  // 仅能修改变量，常量不允许被修改
      count = 0
    }
    func printResult(){
      print("The Count is:\(count)")
    }
    
    mutating func aNewSelf(){  // 给self一个全新的实例，这个实例中count的初始值是500
      self = Counter(count: 500)
    }
}

var c = Counter()
c.compare(100)
c.compare(-100)
c.printResult()
c.reset()

c.aNewSelf()  // 获取新的self实例
c.count  // count已被修改为500


// 枚举中的变异方法可以设置self为不同的成员
enum SwitchStatus{
  case Off, Low, High
  
    mutating func next(){
    
       switch self{
        
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ss = SwitchStatus.Off  // 使用next方法使开关状态不断切换
ss.next()
ss.next()
ss.next()


// 类型方法（OC中的 +方法 ）

// 这是一个成绩处理类，可以获取总成绩，最高最低分，平均分，以及学生人数
class scoreHandler{
    
    static var sum = 0.0, count = 0, max = 0.0, min = 101.0, average = 0.0
    static var maxStu = "", minStu = ""
    
    static func addScore(student stu:Student){
        sum += stu.score
        count++
        average = sum / Double(count)
        
        if max < stu.score{
          max = stu.score
          maxStu = stu.name
        }
        if min > stu.score{
          min = stu.score
          minStu = stu.name
        }
        Student.setScore(highestScore: max, name: maxStu, lowestScore: min, name: minStu)
    }
    
    static func sumScore() -> Double{
       return sum
    }
    
    static func averageScore() -> Double{
      return average
    }
    
    static func maxScore() -> Double{
      return max
    }
    
    static func minScore() -> Double{
      return min
    }
    
    static func studentCount() -> Int{
       return count
    }
}

struct Student {  // 学生结构体，存储学生姓名，成绩以及当前班级中的最高最低分

    var name:String
    var score:Double

    static var highestScore = 0.0, lowestScore = 0.0, highestStu = "", lowestStu = ""
    static func setScore(highestScore max:Double,name highestName:String,lowestScore min:Double, name lowestName:String){  // 设定最高最低分
       highestScore = max
       lowestScore = min
       highestStu = highestName
       lowestStu = lowestName
    }
}

var stu = Student(name: "🐠", score: 10)

scoreHandler.addScore(student: stu)
print("highest:\(Student.highestScore), lowest:\(scoreHandler.minScore()), aver:\(scoreHandler.averageScore()), count:\(scoreHandler.studentCount())")

stu = Student(name: "🐤", score: 20)

// 添加学生及其成绩
scoreHandler.addScore(student: stu)
scoreHandler.addScore(student: Student(name: "🐶", score: 100))
scoreHandler.addScore(student: Student(name: "🐱", score: 59))
scoreHandler.addScore(student: Student(name: "🐷", score: 67))
scoreHandler.addScore(student: Student(name: "🐻", score: 67))
scoreHandler.addScore(student: Student(name: "🐔", score: 99))

print("The Highest Score:\(Student.highestStu) (\(scoreHandler.maxScore()))") // 取最高分及这个学生
print("The Lowest Score:\(Student.lowestStu)(\(scoreHandler.minScore()))")  // 最低分及这个学生
print("The Average:\(scoreHandler.averageScore())")  // 获取平均分
print("The number Of Students:\(scoreHandler.studentCount())")  // 获取学生数
