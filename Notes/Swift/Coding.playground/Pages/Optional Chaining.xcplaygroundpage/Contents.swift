//: Optional Chaining 可空链式调用
// 是一种请求和调用属性、方法和下标的过程。可空性体现在请求或者调用的目标为空，
// 如果目标有值就会调用成功，如果为nil则调用失败



/// 使用可空链式调用来强制展开

class Person{
    var residence:Residence?
}
class Residence{
   var numberOfRooms = 1
}

func printInfo( person:Person){
    // 这里residence可nil，使用"？"来代替"!"Swift将在residence不为空的时候访问这个属性
    if let roomCount = jhon.residence?.numberOfRooms {
        print("jhon's residence has \(roomCount) rooms.")
    }
    else{
        print("unable to retrieve the number of rooms.")
    }
}

let jhon = Person()
printInfo(jhon)   // Residence为空，取值失败。
jhon.residence = Residence()
printInfo(jhon)   // Residence不为空，取值成功。

/// 为可空链式调用定义模型类
class Person0{
    var residence0:Residence0?
}

class Residence0{
   
    var rooms = [Room]()
    var numberOfRooms: Int {
       return rooms.count
    }
    
    subscript( i: Int) -> Room{  // 通过下标来读写对应数据
        get{
           return rooms[i]
        }
        set{
           rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms(){
      print("The number of rooms is: \(numberOfRooms)")   // 根据数组计算的结果
    }
    var address: Address?   // 可空部分
}

class Room {   // Room 只有一个name属性
    var name:String
    init(name:String){ self.name = name }
}

class Address {
    
    var buildingName: String?   // 三个可空属性
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {  // 此函数返回可空字符串，根据两次判断确定返回值
     
        if buildingName != nil{
          return buildingName
        }
        else if buildingNumber != nil{
          return buildingNumber
        }
        else{
          return nil
        }
    }
}

/// 通过可空链式调用访问属性
let tom = Person0()
if let roomCount = tom.residence0?.numberOfRooms {   // residence为nil，一定会失败
   print("Tom has \(roomCount) room(s)")
}
else{
   print("Unable to retrieve the number of Rooms")
}

// 使用可空链式调用设定属性值
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.buildingName = "ChangYangMen"
tom.residence0?.address = someAddress  // 可空链式访问，给属性赋值，这里的操作是无效的，因为residence属性为nil


/// 通过可空链式调用来调用方法
// 这里printNumberOfRooms返回值为Void？ 判断是否为nil来确定调用结果
if tom.residence0?.printNumberOfRooms() != nil {
   print("it was possible to print number Of Rooms!")
}
else{
   print("it was not possible to print number Of Rooms!")
}

if tom.residence0?.address != nil {  // 判断是否赋值成功
   print("it was possible to set address")
}
else{
   print("it was not possible to set address")
}

/// 通过可空链式调用来访问下标
if let firstRoomName = tom.residence0?[0].name{    // 调用一定会失败，residence为nil，"？"要放在"[]"之前
   print("The first room name is \(firstRoomName)")
}
else{
   print("Unable to retrieve the first room name.")
}

tom.residence0?[0] = Room(name: "Bathroom")   // residence0为nil，赋值失败

// 创建一个Residence0实例并赋值给Person实例的属性
let tomsHouse = Residence0()
tomsHouse.rooms.append(Room(name: "Ketchen"))
tomsHouse.rooms.append(Room(name: "Living"))
tom.residence0 = tomsHouse
if let firstRoom = tom.residence0?[0].name{   // 这里可空链式调用成功，已经给residence0属性赋值
   print("The first room name is \(firstRoom).")
}
else{
   print("Unable to retrieve the first room name.")
}

///  访问可空类型的下标
//  字典键后加"?"进行可空访问
var testScores = ["Dave":[82, 96, 58], "Jim":[78, 89, 97]]
testScores["Dave"]?[0] = 91    // Dave 82 -> 91，
testScores["Jim"]?[0]++   // Jim 78 += 1
testScores["Tim"]?[0] = 84   // 赋值失败，不存在Tim这个键

/// 多层链接
/*
  ①如果你访问的值不是可空的，通过可空链式调用将会放回可空值。
  ②如果你访问的值已经是可空的，通过可空链式调用不会变得“更”可空。
*/

// 两层可空链式调用，residence0、address均为可空值
// residence0不为nil，而address为nil，如果tom.residence0.address指向一个实例并且有street值，这里就可以成功访问
if let tomsStreet = tom.residence0?.address?.street{
    print("Tom's street name is \(tomsStreet)")
}
else{
    print("Unable to retrieve the address")
}

let tomsAddress = Address()
tomsAddress.buildingName = "Beihang University"
tomsAddress.street = "College Road"
tomsAddress.buildingNumber = "37"
tom.residence0?.address = tomsAddress  // residence0 属性有效，这里可以成功赋值

if let tomsStreet = tom.residence0?.address?.street{  // address属性是有效值，可以取到
  print("Tom's street name is \(tomsStreet)")
}
else{
  print("Unable to retrieve the address")
}

/// 对返回可空值的函数进行链接

// 如下代码通过可空链式调用的方法最终返回值仍是 String？
if let buildingIdentifier = tom.residence0?.address?.buildingIdentifier() {
  print("Tom's building identifier is \(buildingIdentifier)")
}

// 继续对返回值进行可空链式调用在"()"之后加"?"
// 返回值可空不是方法本身可空
if let BeginWithBeihang = tom.residence0?.address?.buildingIdentifier()?.hasPrefix("Beihang"){
   print("Tom's building identifier is begin with \"Beihang\"")
}





