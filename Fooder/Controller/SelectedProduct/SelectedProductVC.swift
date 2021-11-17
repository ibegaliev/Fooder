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

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var dist: UILabel!
    var realm = try! Realm()
    
    var data: ProductDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        
    }

    func setting(){
        
        dist.text = data?.discription
        cost.text = "\(data?.cost ?? 0)"
        productName.text = data?.name
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = data?.photo.count ?? 1
        pageControl.addTarget(self, action: #selector(pageControlEditing), for: .touchDragInside)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SelectedProductCell", bundle: nil), forCellWithReuseIdentifier: "SelectedProductCell")
    }
    
    @IBAction func heardTapped(_ sender: UIButton) {
        
        guard let data = data else {return}
        
        if data.isLike {
            UIView.animate(withDuration: 0.15, delay: 0, options: .autoreverse) {
                sender.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            } completion: { [self] _ in
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                data.isLike = false
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                do {
                    try! realm.write{
                        realm.delete(data)
                        print(realm.objects(ProductDM.self))
                    }
                }
            }
        } else {
            UIView.animate(withDuration: 0.15, delay: 0, options: .autoreverse) {
                sender.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            } completion: { [self] _ in
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                data.isLike = true
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                do {
                    try! realm.write{
                        realm.add(data)
                        print(realm.objects(ProductDM.self))
                    }
                }
            }
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.photo.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedProductCell", for: indexPath) as! SelectedProductCell
        cell.updateCell(image: data?.photo[indexPath.row] ?? " ")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
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
     
    @objc func pageControlEditing(){
        
        collectionView.contentOffset = CGPoint(x:pageControl.numberOfPages, y: 1)
        collectionView.reloadData()
        print("----------")
        
    }
    
}
