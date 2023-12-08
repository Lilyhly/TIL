import Foundation
var selectedMenu: [String] = []

while true {
    print(
  """
  [ SHAKESHACK MENU ]
  1. Burgers   | 앵거스 비프 통살을 다져만든 버거
  2. Forzen Custard | 매장에서 신선하게 만드는 아이스크림
  3. Drinks   | 매장에서 직접 만드는 음료
  4. Beer   | 뉴욕 브루클린 브루어리에서 양조한 맥주
  0. 종료   | 프로그램 종료
  
  """)
    
    
    if let input = readLine() {
        switch input {
        case "0":
            print ("프로그램 종료")
        case "1":
            print("1번 메뉴입니다. ")
            selectedMenu.append("1번")
        case "2":
            print("2번 메뉴입니다. ")
            selectedMenu.append("2번")
        case "3":
            print("3번 메뉴입니다.")
            selectedMenu.append("3번")
        case "4":
            print ("4번 메뉴입니다. ")
            selectedMenu.append("4번")
        default:
            print("없는 메뉴 입니다, 다시 선택해주세요.")
        }
    }
    
}


//- 필요한 클래스들을 설계해요 (버거, 아이스크림, 음료, 맥주, 주문, 공통 등)
//- 클래스들의 프로퍼티와 메소드를 정의해요
//- 메소드를 이용해서 Lv1의 코드를 개선해요

class MenuItem {
    let name: String
    let description: String
    let price: Double
    
    init(name: String, description: String, price: Double) {
        self.name = name
        self.description = description
        self.price = price
    }
}

let burgers = MenuItem (name: "ShackBurger", description: "토마토, 양상추, 쉑소스가 토핑된 치즈버거", price: 6.9)
let frozenCustard = MenuItem(name: "Frozen Custard", description: "매장에서 신선하게 만드는 아이스크림", price: 6.0)
let drinks = MenuItem(name: "drinks", description: "매장에서 직접 만드는 음료", price: 5.5)
let beer = MenuItem(name: "beer", description: "뉴욕 브루클린 브루어리에서 양조한 맥주", price: 4.6)


class Order {
    var items: [MenuItem] = []

    func addItem(_ item: MenuItem) {
        items.append(item)
    }

    func calculateTotal() -> Double {
        return items.reduce(0) { $0 + $1.price }
    }
}

import Foundation

let burgerMenu = [
    burgers,
    frozenCustard,
   

