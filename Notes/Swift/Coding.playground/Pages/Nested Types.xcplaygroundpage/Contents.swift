///  嵌套类型 Nested Types
/*
   要在一个类型中嵌套另一个类型，将需要嵌套的类型的定义写在被嵌套类型的区域{}内，而且可以根据需要定义多级嵌套
*/

/// 嵌套类型实例

struct BlackjackCard {
     // 嵌套定义枚举型Suit
    enum Suit:Character{  // 枚举扑克牌四种花色
        case Spades = "♠", Hearts = "♥", Diamonds = "♦", Clubs = "♣"
    }
    
    // 嵌套定义枚举型Rank
    enum Rank: Int{  // 枚举扑克牌所有点数
      case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
      case Jack, Queen, King, Ace
      
        struct Values {
            let first:Int, second:Int?
        }
        
        var values: Values{
            switch self{
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard属性和方法
    let rank: Rank, suit: Suit
    var description:String{
        var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second{
          output += " or \(second)"
        }
        return output
    }
}


let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("\(theAceOfSpades.description)")

/// 嵌套类型的引用
// 在外部对嵌套类型的引用，以被嵌套类型的名字为前缀，加上所要引用的属性名：
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue






