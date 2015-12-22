/// Error Handling 错误处理
// swift提供第一类错误支持，包括在运行时抛出，捕获，传送和控制可回收错误。


/// 错误的表示
// 用符合ErrorType协议的值表示
enum VendingMachineError:ErrorType{
    case InvalidSelection   // 物品不存在
    case InsufficientFunds(required:Double)  // 已投入金额低于物品价格
    case OutOfStock  // 卖光了
    case Unkown
}

/*
  函数抛出错误
  func canThrowErrors() throws -> String
  func cannotThrowErrors() -> String

*/
struct Item {   // 待售卖的东西，价格和数量
    var price:Double
    var count:Int
}

// 贩卖机留存的物品
var inventory = ["Candy Bar": Item(price: 1.25, count: 7), "Chips":Item(price: 1.00, count: 4), "Pretzels": Item(price: 0.75, count: 11)]
var amountDeposited = 1.00  // 当前金额

func vend(ItemName name:String) throws{  // 有错误抛出在参数后接"throws" ,对应地方使用"throw"抛出错误

    guard var item = inventory[name] else{   // 检测有没有这个商品
       throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else{  // 检测商品数量
       throw VendingMachineError.OutOfStock
    }
    
    if amountDeposited >= item.price{
       amountDeposited -= item.price
       --item.count
        inventory[name] = item
    }
    else{    // 金额不足的情况
       let amountRequired = item.price - amountDeposited
       throw VendingMachineError.InsufficientFunds(required: amountRequired)
    }
}

let favoriteSnacks = [ "Alice": "Chips", "Bob": "Licorice", "Eve": "Pretzels"]
func buyFavoriteSnack( person:String) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vend(ItemName: snackName)   // 函数名前加"try"来捕捉错误，这里的错误将会被向上传递到buyFavoriteSnack并抛出
}

/// 捕捉和处理错误
/*
  使用do-catch来捕捉错误
  do{
    try function that throws
     statements
  }
  catch patter{
    statements
  }
  一个错误被抛出，会被catch接收并处理
*/

// Swift处理错误不会调用堆栈，能减少性能消耗，throw和return类似
do{
   try vend(ItemName: "Candy Bar")  //Enjoy delicious snack
}
catch VendingMachineError.InvalidSelection{   // 如果抛出错误，会对应处理
      print("Invalid Selection")
}
catch VendingMachineError.OutOfStock{
      print("Out Of Stock")
}
catch VendingMachineError.InsufficientFunds(let amountRequired){
      print("Insufficient Funds,please insert an additional $\(amountRequired)")
}

/// 禁止错误传播
func willOnlyThrowIfTrue( value: Bool) throws{
    if value{ throw VendingMachineError.Unkown }
}

// 抛出错误，处理错误
do{
    try willOnlyThrowIfTrue( true)
}
catch{
   // 处理错误
}

try! willOnlyThrowIfTrue(false) // 如果确定不会抛出错误，使用try! 禁止错误抛出。如果抛出错误，会触发运行时错误


/// 收尾操作
// defer无论如何都会执行，不管是否抛出了错误
enum StringError:ErrorType{
   case Empty
}

func printSomething(var str: String?) throws{
    
    defer{    // 延迟到流程走完,defer执行顺序相反，第一个会在第二个之后执行
        print("running defer code")
        str = ""
    }

    if str!.isEmpty {
      throw StringError.Empty
    }
    else{
      print("\(str!)")
    }
}

// ①捕捉错误
do{
    try printSomething("")
}
catch{
   print("String is empty")
}

// ②没有错误
try! printSomething("I'm the best!")  // 看打印信息，这里defer语句在输出后执行了





