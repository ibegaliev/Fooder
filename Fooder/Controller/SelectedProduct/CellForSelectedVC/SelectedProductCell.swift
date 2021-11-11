//
//  SelectedProductCell.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/8/21.
//

import UIKit
import SDWebImage

class SelectedProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(image: String){
        productImage.sd_setImage(with: URL(string: AppURL.baseURL + image))
    }
}
