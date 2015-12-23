/// 类型转换 Type Casting
// Swift可以判断实例类型，也可以将实例看做是其父类或者子类的实例
// 类型转换使用is和as来实现。这两个操作符提供一种简单达意的方式来检查值类型或者转换其类型

/// 定义一个类层次作为例子
class MediaItem{     // 媒体项目基础类，一个name属性
    var name:String
    init(name:String){
      self.name = name
    }
}

class Movie: MediaItem {   // 电影类，增加一个director属性
    var director:String
    init( name:String, director:String){
       self.director = director
       super.init(name: name)
    }
}

class Song: MediaItem {   // 歌曲类，增加一个artist属性
    var artist:String
    init( name:String, artist:String){
      self.artist = artist
      super.init(name: name)
    }
}

// 媒体库
let library = [
      Movie(name: "Leon", director: "Luc Besson"),
      Song(name: "Lift", artist: "Tobu"),
      Movie(name: "Interstellar", director: "Christopher Nolan"),
      Movie(name: "Inception", director: "Christopher Nolan"),
      Song(name: "Yellow", artist: "Coldplay"),
      Song(name: "Everybody knows I love you", artist: "Lovebugs"),
      Song(name: "Explosive", artist: "Bond")
     ]

/// 检查类型
// 使用"is"来判断一个实例是否是某种类
var movieCount = 0
var songCount = 0
for item in library{
    if item is Movie{   // "item is Movie" 这个实例是Movie实例
      movieCount++
    }
    else if item is Song{   // "item is Song" 这个实例是Song实例
      songCount++
    }
}
print("This library contains \(movieCount) Movies and \(songCount) Songs")

/// 向下转型
// 将实例转化为其一个子类，as?为可空类型，转化结果是nil或者这个子类单例；as!强制转化，如果不能成功转化将会触发运行时错误
for item in library{

    if let movie = item as? Movie{   //
        print("Movie:\(movie.name), dir:\(movie.director)")
    }
    else if let song = item as? Song{   //
        print("Song:\(song.name), by:\(song.artist)")
    }
}

/// Any和AnyObject的类型转化
// Any可以表示任何类型，包括方法类型（function types）。
// AnyObject可以代表任何类的实例

// AnyObject类型
let someObjects:[AnyObject] = [
    Movie(name: "The Terminal", director: "Steven Allan Spielberg"),
    Movie(name: "Star Wars: The Force Awakens", director: "Jeffrey Jacob Abrams"),
    Movie(name: "Big Hero 6", director: "Don hall")
]

for object in someObjects{
   let movie = object as! Movie   // 强行转化
   print("Movie:\(movie.name), Dir:\(movie.director)")
}

for movie in someObjects as! [Movie]{   // 直接对数组进行转化
    print("Movie:\(movie.name), Dir:\(movie.director)")
}

// Any类型
// Any类型可以混合不同类型进行工作，包括方法类型和非Class类型
var things = [Any]()

things.append( 0)
things.append( 0.0)
things.append( 42)
things.append( 3.1415926)
things.append( "hello")
things.append( (3.0, 5.0))
things.append( Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append( {(name:String) -> String in "hello \(name)"})


for thing in things{   // 在switch分支语句中使用as而不是as?来检查和转换到一个明确类型，在Swift中这种总是安全的
  
    switch thing{
    
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as an Double")
    case let someInt as Int:
        print("an Integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("an Double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print!")
    case let someString as String:
        print("a string value of \(someString)")
    case let (x, y) as (Double, Double):
        print("an (x, y) at point (\(x), \(y))")
    case let movie as Movie:
        print("a movie called:\(movie.name), dir:\(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
        
    default:
        print("something else")
    }
}
















