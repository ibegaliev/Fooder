//
//  FoodsDM.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/6/21.
//
import UIKit
import SwiftyJSON
import RealmSwift

class ProductDM: Object {
    
    var photo = List<String>()
    @objc dynamic var _id: String
    @objc dynamic var name: String
    @objc dynamic var cost: Double
    @objc dynamic var discription: String
    @objc dynamic var isLike: Bool = false
    
    required override init(){
        _id = ""
        name = ""
        cost = 0
        discription = ""
    }
    
    init(json: JSON) {
        self._id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.cost = json["cost"].doubleValue
        self.discription = json["description"].stringValue
        let photo1 = List<String>()
        for ph in json["photo"].arrayValue{
            photo1.append(ph.stringValue)
        }
        self.photo = photo1
    }
    
    
}
