//
//  MainTBC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit

class MainTBC: UITabBarController {

//    MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarBuilder()
    }
    
    
    func tabbarBuilder(){
//        MARK: - tabbar builder
        let vc1 = HomeVC()
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let vc2 = HeartVC()
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        let vc3 = PersonVC()
        vc3.tabBarItem.image = UIImage(systemName: "person")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        let vc4 = HistoryVC()
        vc4.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "clock.arrow.circlepath")
        
        let vc = [vc1, vc2, vc3, vc4]
        for vc in vc {
            vc.view.backgroundColor = IColor.hexStrToColor(hex: "F2F2F2")
        }
        
        viewControllers = vc
        tabBar.backgroundColor = .none
        tabBar.tintColor = IColor.hexStrToColor(hex: "F94C07")
        tabBar.barTintColor = IColor.hexStrToColor(hex: "A6A7A8")
    }

}
