//
//  HeartVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit

class HeartVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var data = [ProductDM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IColor.hexStrToColor(hex: "#F6F6F9")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(UINib(nibName: "ProductsCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsCVC")
    }
    
    
    
}


extension HeartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVC", for: indexPath) as! ProductsCVC
        cell.updateCell(image: data[indexPath.row].photo.first!, name: data[indexPath.row].name, cost: "\(data[indexPath.row].cost)")
        return cell
    }
    
}
