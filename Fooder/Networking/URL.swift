import UIKit
import SwiftyJSON


class AppURL {
    
    static let baseURL = "https://foodie-back-end.herokuapp.com"
    
    struct EndPoinds{
        static let login = "/api/auth"
        static let register = "/api/users"
        static let categories = "/api/categories"
        static let drink = "/api/drinks"
        static let souces = "/api/souces"
        static let snacks = "/api/snacks"
        static let foods = "/api/foods"
        static let location = "/api/gio"
    }
    
    static let registerURL: URL = URL(string: baseURL + EndPoinds.register)!
    static let loginURL: URL = URL(string: baseURL + EndPoinds.login)!
    static let categories: URL = URL(string: baseURL + EndPoinds.categories)!
    static let drinks: URL = URL(string: baseURL + EndPoinds.drink)!
    static let souces: URL = URL(string: baseURL + EndPoinds.souces)!
    static let foods: URL = URL(string: baseURL + EndPoinds.foods)!
    static let snacks: URL = URL(string: baseURL + EndPoinds.snacks)!
    
    
}
