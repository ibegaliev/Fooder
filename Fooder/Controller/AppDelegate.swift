//
//  AppDelegate.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/1/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let realm = try! Realm()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        
        print(realm.configuration.fileURL!)
        window?.makeKeyAndVisible()
        if AppCashe.readFromCache().count < 1 {
            window?.rootViewController = RedVC(nibName: "RedVC", bundle: nil)
        } else {
            window?.rootViewController = MainTBC(nibName: "MainTBC", bundle: nil)
        }
        
        return true
    }


}

