//
//  CardTVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/16/21.
//

import UIKit
import SDWebImage

class CardTVC: UITableViewCell {
    
    @IBOutlet weak var numbLabel: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func minusBtnTapped(_ sender: Any) {
        if Int(numbLabel.text!)! >= 1 {
            numbLabel.text = "\(Int(numbLabel.text!)! - 1)"
        }
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        numbLabel.text = "\(Int(numbLabel.text!)! + 1)"
    }
    
    func updateCell(name: String, cost: String, image: String){
        nameLbl.text = name
        costLbl.text = cost
        img.sd_setImage(with: URL(string: AppURL.baseURL + image))
    }
    
}

