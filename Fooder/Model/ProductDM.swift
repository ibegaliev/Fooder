//
//  FoodsDM.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/6/21.
//

import UIKit
import SwiftyJSON
import RealmSwift

class ProductDM{
    
    var photo: [String]
    var _id: String
    var name: String
    var cost: Double
    var discription: String
    
    init(json: JSON) {
        self._id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.cost = json["cost"].doubleValue
        self.discription = json["description"].stringValue
        var phs = [String]()
        for ph in json["photo"].arrayValue {
            phs.append(ph.stringValue)
        }
        self.photo = phs
    }
    
    
}
