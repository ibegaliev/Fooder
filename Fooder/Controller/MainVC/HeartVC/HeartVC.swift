//
//  HeartVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit
import RealmSwift
import SwiftyJSON

class HeartVC: UIViewController {

//    MARK: - variables
    @IBOutlet weak var collectionView: UICollectionView!
    var data = [ProductDM]()
    var realm = try! Realm()
    
//    MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
    }
    
//    MARK: - view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readDataFromRealm()
    }
    
//    MARK: - func settings
    fileprivate func settings(){
        view.backgroundColor = IColor.hexStrToColor(hex: "#F6F6F9")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(UINib(nibName: "ProductsCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsCVC")
    }
    
//    MARK: - read data from realm
    fileprivate func readDataFromRealm(){
        do {
            data.removeAll()
            try! realm.write{
                for datum in realm.objects(ProductDM.self) {
                    data.append(datum)
                }
                collectionView.reloadData()
            }
        }
    }
    
}


extension HeartVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    MARK: - number of section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
//    MARK: - cell for row at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVC", for: indexPath) as! ProductsCVC
        cell.updateCell(image: data[indexPath.row].photo.first!, name: data[indexPath.row].name, cost: "\(data[indexPath.row].cost)")
        return cell
    }
    
//    MARK: - collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width*0.45, height: collectionView.frame.height*0.35)
    }
    
//MARK: - did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedProductVC(nibName: "SelectedProductVC", bundle: nil) as! SelectedProductVC
        vc.data = data[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
