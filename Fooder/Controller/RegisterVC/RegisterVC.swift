//
//  RegisterVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/2/21.
//

import UIKit
import TextFieldEffects
import SnapKit
import IQKeyboardManagerSwift

class RegisterVC: UIViewController {

    
//    MARK: - verebles
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet var stacks: [UIStackView]!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var singView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funcForViewDidLoad()
    }

//    MARK: - login button tapped
    @IBAction func loginBtnTapped(_ sender: Any) {

        UIView.animate(withDuration: 0.1, animations: {
            for stack in self.stacks {
                stack.isHidden = true
            }
            self.loginView.isHidden = false
            self.singView.isHidden = true
            self.view.layoutIfNeeded()
        })
        
    }
    
//    MARK: - sing button tapped
    @IBAction func singUpBtnTapped(_ sender: Any) {

        UIView.animate(withDuration: 0.1, animations: {
            for stack in self.stacks {
                stack.isHidden = false
            }
            self.loginView.isHidden = true
            self.singView.isHidden = false
            self.view.layoutIfNeeded()
        })
        
    }
    
//    MARK: - login button pressed
    @IBAction func loginPressed(_ sender: Any) {
        let tvc = MainTBC()
        tvc.modalPresentationStyle = .overFullScreen
        
        if stacks[0].isHidden {
            API.login(phone: emailTF.text!, password: passwordTF.text!) { token in
                AppCashe.saveToCache(token!)
                if !AppCashe.readFromCache().isEmpty {
                    self.present(tvc, animated: true, completion: nil)
                }
            }
        } else if stacks[0].isHidden == false {
            API.register(email: emailTF.text!, birthday: birthdayTF.text!, phone: Int(phoneTF.text!)!, password: passwordTF.text!) { token in
                AppCashe.saveToCache(token!)
                if !AppCashe.readFromCache().isEmpty {
                    self.present(tvc, animated: true, completion: nil)
                }
            }
        }
    }
}

extension RegisterVC{
    
//    MARK: - view did load
    func funcForViewDidLoad(){
        
        loginView.backgroundColor = IColor.hexStrToColor(hex: "#FA4A0E")
        singView.layer.cornerRadius = 2
        loginView.layer.cornerRadius = 2
        
        titleView.layer.shadowColor = UIColor.black.cgColor
        titleView.layer.shadowOpacity = 0.2
        titleView.layer.shadowOffset = .zero
        titleView.layer.shadowRadius = 10
        
        IQKeyboardManager.shared.enable = false
    }
    
}
