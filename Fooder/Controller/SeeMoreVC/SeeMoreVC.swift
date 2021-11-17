//
//  SeeMoreVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/5/21.
//

import UIKit

class SeeMoreVC: UIViewController {

    
//    MARK: - vars
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [ProductDM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
        settings()
    }

    func settings(){
//        MARK: - settings
        
        view.backgroundColor = IColor.hexStrToColor(hex: "#F2F2F2")
        collectionView.backgroundColor = IColor.hexStrToColor(hex: "#F2F2F2")
        
        searchTF.becomeFirstResponder()
        searchTF.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductsCVC", bundle: nil), forCellWithReuseIdentifier: "ProductsCVC")
        
    }
    
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK: - did select item
extension SeeMoreVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedProductVC(nibName: "SelectedProductVC", bundle: nil) 
        vc.data = data[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    
}

//MARK: - size for item at
extension SeeMoreVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width*0.45, height: collectionView.frame.height*0.4)
    }
    
}

extension SeeMoreVC: UICollectionViewDataSource {
    
//    MARK: - number of item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    
//    MARK: - cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCVC", for: indexPath) as! ProductsCVC
//        cell.updateCell(image: data[indexPath.row].photo, name: data[indexPath.row].name, cost: "\(data[indexPath.row].cost)")
        return cell
        
    }
    
}


extension SeeMoreVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("------------------------")
        
        return true
    }
    
}


extension SeeMoreVC {
    
    func uploadData(){
        
        API.foods { [self] dt in
            for d in dt {
                data.append(d)
                print(d.photo)
            }
            collectionView.reloadData()
        }

        
        API.snacks { [self] dt in
            for d in dt {
                data.append(d)
            }
            collectionView.reloadData()
        }
        
        API.drinks{ [self] dt in
            for d in dt {
                data.append(d)
            }
            collectionView.reloadData()
        }

        
        API.souces { [self] dt in
            for d in dt {
                data.append(d)
            }
            collectionView.reloadData()
        }
                
    }
    
}
