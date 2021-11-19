//
//  AppRealm.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/10/21.
//

import UIKit
import RealmSwift

class AppRealm{
    
    static let shared = AppRealm()
    private var realm: Realm!
    
    init() {
        realm = try! Realm()
        print(realm.configuration.fileURL ?? "👉")
    }
    
    func saveItemToFavorites(data: ProductDM){
        do {
            print(data)
            try! realm.write{
                data.isLike = true
                realm.add(data, update: .modified)
            }
        }
        print(realm.objects(ProductDM.self))
    }
    
    func fetchItemsFromFavorites() -> [ProductDM]{
        return realm.objects(ProductDM.self).compactMap{$0}
    }
    
    func deleteItemFromFavorites(data: ProductDM){
        do {
            try! realm.write{
                for dt in realm.objects(ProductDM.self){
                    if dt == data {
                        realm.delete(data)
                    }
                }
                print(realm.objects(ProductDM.self))
            }
        }
    }
    
}
