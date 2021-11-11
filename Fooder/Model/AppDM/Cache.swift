//
//  Cache.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/6/21.
//

import UIKit

class AppCashe {
    
    class func saveToCache(_ data : String) {
        UserDefaults.standard.set(data, forKey: UserPassword.tokenName)
    }
    
    class func readFromCache() -> String{
        return UserDefaults.standard.string(forKey: UserPassword.tokenName) ?? ""
    }
    
}
