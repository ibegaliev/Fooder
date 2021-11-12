import UIKit
import SwiftyJSON
import Alamofire


class API {
    
    
//    MARK: - request for REGISTER❕
    class func register(email:String, birthday: String, phone: Int, password: String, completion: @escaping (String?)->()){
        
        let parametrs: [String : Any] = [
            "name": email,
            "birthday": birthday,
            "phone": phone,
            "password": password
        ]
        
        AF.request(AppURL.registerURL, method: .post, parameters: parametrs, encoding: URLEncoding.queryString, headers: nil, interceptor: nil,  requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            if json["success"].boolValue {
                print(json["token"].stringValue,"✅✅✅")
            } else {
                print(json["message"].stringValue, "❓❓❓")
            }
            completion(json["token"].stringValue)
            
        }
        
    }
    
//    MARK: - request for LOGIN❕
    class func login(phone:String, password: String, completion: @escaping (String?)->()){
        
        let params: [String: Any] = [
            "phone": phone,
            "password": password
        ]
        
        AF.request(AppURL.loginURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            
            if json["success"].boolValue {
                print(json["data"].stringValue, "✅✅✅")
            } else {
                print(json["message"].stringValue, "❓❓❓")
            }
            
        }
        
    }
    
//    MARK: - souces
    class func souces(completion: @escaping ([ProductDM])->()){
        
        var product = [ProductDM]()
        let hearder : HTTPHeaders = [
            "Authorization" : AppCashe.readFromCache()
        ]
        
        AF.request(AppURL.souces, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: hearder, interceptor: nil, requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            if json["success"].boolValue {
                for data in json["data"].arrayValue{
                    let item = ProductDM.init(json: data)
                    product.append(item)
                }
                completion(product)
                print("✅-souces")
            } else {
                print(json["message"].stringValue, "🤬🤬🤬")
            }
        }
        
    }
    
//    MARK: - drinks
    class func drinks(completion: @escaping ([ProductDM]) -> ()){
        
        var product = [ProductDM]()
        let hearder : HTTPHeaders = [
            "Authorization" : AppCashe.readFromCache()
        ]
        
        
        AF.request(AppURL.drinks, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: hearder, interceptor: nil, requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            if json["success"].boolValue {
                for data in json["data"].arrayValue{
                    let item = ProductDM.init(json: data)
                    product.append(item)
                }
                completion(product)
                print("✅-drinks")
            } else {
                print(json["message"].stringValue, "🤬🤬🤬")
            }
        }
        
    }
    
    
    //    MARK: - snacks
    class func snacks(completion: @escaping ([ProductDM])->()){
        
        var product = [ProductDM]()
        let hearder : HTTPHeaders = [
            "Authorization" : AppCashe.readFromCache()
        ]
        
        AF.request(AppURL.snacks, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: hearder, interceptor: nil, requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            if json["success"].boolValue {
                for data in json["data"].arrayValue{
                    let item = ProductDM.init(json: data)
                    product.append(item)
                }
                completion(product)
                print("✅-snacks")
            } else {
                print(json["message"].stringValue, "🤬🤬🤬")
            }
        }
        
    }
    
    //    MARK: - foods
    class func foods(completion: @escaping ([ProductDM])->()){
        
        var product = [ProductDM]()
        let hearder : HTTPHeaders = [
            "Authorization" : AppCashe.readFromCache()
        ]
        
        AF.request(AppURL.foods, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: hearder, interceptor: nil, requestModifier: nil).responseJSON { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            if json["success"].boolValue {
                for data in json["data"].arrayValue{
                    let item = ProductDM.init(json: data)
                    product.append(item)
                }
                completion(product)
                print("✅-foods")
            } else {
                print(json["message"].stringValue, "🤬🤬🤬")
            }
        }
        
    }
    
}

