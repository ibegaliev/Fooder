//
//  HeaderCVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/4/21.
//

import UIKit

class HeaderCVC: UICollectionViewCell {

    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.layer.cornerRadius = 2
    }
    
    
    func updateCell(item: CategoryDM){
//        MARK: - update cell
        label.text = item.name
        if item.isSelected {
            selectedView.backgroundColor = IColor.hexStrToColor(hex: "#FA0000")
        } else {
            selectedView.backgroundColor = IColor.hexStrToColor(hex: "#F2F2F2")
        }
    }
    
}
