//
//  HomeVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit
import SwiftUI


class HomeVC: UIViewController {

//    MARK: - vars
    var product: [ProductDM]?
    var headerLabel: [CategoryDM] = [
        CategoryDM(id: "1", name: "Foods", isSelected: true, funcUrl: AppURL.foods),
        CategoryDM(id: "1", name: "Drinks", isSelected: false, funcUrl: AppURL.drinks),
        CategoryDM(id: "1", name: "Snacks", isSelected: false, funcUrl: AppURL.snacks),
        CategoryDM(id: "1", name: "Sauce", isSelected: false, funcUrl: AppURL.souces)
    ]
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var seeButton: UIButton!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
        headerReload()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("@@@@", product)
    }
    
    func headerReload(){
        for headerLabel in headerLabel.enumerated() {
            if headerLabel.element.isSelected {
                switch headerLabel.offset{
                case 0:
                    API.foods { [self] data in
                        product = data
                        collectionView1.reloadData()
                    }
                    
                case 1:
                    API.drinks { [self] data in
                        product = data
                        collectionView1.reloadData()
                    }
                    
                case 2:
                    API.snacks { [self] data in
                        product = data
                        collectionView1.reloadData()
                    }
                    
                case 3:
                    API.souces { [self] data in
                        product = data
                        collectionView1.reloadData()
                    }
                default:
                    print("❗️❗️❗️")
                }
            }
        }
    }
    
    func settings(){
        
        searchTF.delegate = self
        
        seeButton.setTitle("see more", for: .normal)
        seeButton.setTitleColor(IColor.hexStrToColor(hex: "FA4A0C"), for: .normal)
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.backgroundColor = IColor.hexStrToColor(hex: "#F2F2F2")
        headerCollectionView.register(UINib(nibName: "HeaderCVC", bundle: nil), forCellWithReuseIdentifier: "HeaderCVC")
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.backgroundColor = IColor.hexStrToColor(hex: "#F2F2F2")
        collectionView1.register(UINib(nibName: "ProductsCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsCVC")
    }
    
    @IBAction func cardButtonTapped(_ sender: Any) {
        let vc = CardVC(nibName: "CardVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func seePressed(_ sender: Any) {
//MARK: - see more button pressed
        let vc = SeeMoreVC(nibName: "SeeMoreVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
}





//MARK: collection view delegate and data sourse
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionView1 {
            return product?.count ?? 0
        } else {
            return headerLabel.count
        }
        
    }
    
//    MARK: collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1 {
            return CGSize(width: self.collectionView1.frame.width*0.45, height: self.collectionView1.frame.height*0.9)
        } else {
            return CGSize(width: self.headerCollectionView.frame.width*0.25, height: self.headerCollectionView.frame.height*0.7)
        }
    }
    
    
//    MARK: - collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVC", for: indexPath) as! ProductsCVC
            cell.updateCell(image: (product?[indexPath.row].photo.first) ?? "eeee", name: product?[indexPath.row].name ?? "", cost: "\(product![indexPath.row].cost)")
            return cell
            
        } else {
            
            let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCVC", for: indexPath) as! HeaderCVC
            cell.updateCell(item: headerLabel[indexPath.row])
            return cell
            
        }
        
    }
    
    
}

extension HomeVC: UITextFieldDelegate {
//    MARK: - text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = SeeMoreVC(nibName: "SeeMoreVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}



extension HomeVC: UICollectionViewDelegate{
//MARK: Collection view did select row
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView1 {
            let vc = SelectedProductVC(nibName: "SelectedProductVC", bundle: nil)
            vc.data = product?[indexPath.row]
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        } else if collectionView == headerCollectionView {
            for i in headerLabel.enumerated() where i.element.isSelected {
                headerLabel[i.offset].isSelected = false
            }
            headerLabel[indexPath.row].isSelected = true
            headerReload()
            headerCollectionView.reloadData()
        }
    }
    
}
