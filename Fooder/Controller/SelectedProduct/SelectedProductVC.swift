//
//  SelectedProductVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/5/21.
//

import UIKit
import SDWebImage
import RealmSwift

class SelectedProductVC: UIViewController {

//    MARK: - verebles:
    @IBOutlet weak var favoriteImgView: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var dist: UILabel!
    
    var data: ProductDM?
    var data1: ProductDM?
    var isLike: Bool?
    
//    MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchedItems = AppRealm.shared.fetchItemsFromFavorites()
        for i in fetchedItems where i._id == data?._id {
            data = i
            break
        }
        setting()
        data1 = data
    }

//    MARK: - setting
    func setting(){
        if let data = data {
            dist.text = data.discription
            cost.text = "\(data.cost)"
            productName.text = data.name
            favoriteImgView.setImage(data.isLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart") , for: .normal)
            isLike = data.isLike
            pageControl.currentPage = 0
            pageControl.numberOfPages = data.photo.count
            pageControl.addTarget(self, action: #selector(pageControlEditing), for: .touchDragInside)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "SelectedProductCell", bundle: nil), forCellWithReuseIdentifier: "SelectedProductCell")
        }
        
    }
    
//    MARK: - heard tapped
    @IBAction func heardTapped(_ sender: UIButton) {
        
        guard let data = data else {return}
        
        if isLike! {
            print("----------------")
            isLike = false
            UIView.animate(withDuration: 0.15, delay: 0, options: .autoreverse) {
                sender.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            } completion: { _ in
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                AppRealm.shared.deleteItemFromFavorites(data: data)
            }
        } else {
            print("++++++++++++++++")
            isLike = true
            UIView.animate(withDuration: 0.15, delay: 0, options: .autoreverse) {
                sender.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            } completion: { _ in
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                AppRealm.shared.saveItemToFavorites(data: self.data1!)
            }
        }
    }
    
//    MARK: - back button tapped
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
//    MARK: - add card tapped
    @IBAction func addToCardd(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}



extension SelectedProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    MARK: - number of section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.photo.count ?? 0
    }
    
//    MARK: - cell for row at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedProductCell", for: indexPath) as! SelectedProductCell
        cell.updateCell(image: data?.photo[indexPath.row] ?? " ")
        return cell
    }
    
//    MARK: - cell for item at
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
//    MARK: - scroll view did scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.pageControl.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
            self.collectionView.transform = CGAffineTransform(scaleX: 0.995, y: 0.995)
        } completion: { _ in
            self.collectionView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.pageControl.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }

        
        
    }
    
}


extension SelectedProductVC {

//        MARK: - page controller editing
    @objc func pageControlEditing(){
        collectionView.contentOffset = CGPoint(x:pageControl.numberOfPages, y: 1)
        collectionView.reloadData()
        print("----------")
        
    }
    
}
