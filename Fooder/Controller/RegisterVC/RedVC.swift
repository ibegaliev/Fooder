//
//  RedVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit

class RedVC: UIViewController {

    @IBOutlet weak var btnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOutlet.setTitle("Get started", for: .normal)
        btnOutlet.tintColor = IColor.hexStrToColor(hex: "#FF4B3A")
        btnOutlet.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
    }

    
//    MARK: - start button tapped
    @IBAction func StartButtonTapped(_ sender: Any) {
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
