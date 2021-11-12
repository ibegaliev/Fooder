//
//  ProductsCVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/3/21.
//

import UIKit
import SDWebImage

class ProductsCVC: UICollectionViewCell {

    
    
    @IBOutlet weak var imageForCell: UIImageView!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageForCell.layer.cornerRadius = imageForCell.frame.height*0.5
    }

//    MARK: - update cell
    func updateCell(image: [String], name: String, cost: String){
        productCost.text = cost
        productName.text = name
        imageForCell.sd_setImage(with: URL(string: AppURL.baseURL + image.first!))
    }
    
}
