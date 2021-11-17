//
//  CardVC.swift
//  Fooder
//
//  Created by ibrohim begaliev on 11/16/21.
//

import UIKit

class CardVC: UIViewController {

    var product = [ProductDM]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customs()
        reloadProducts()
    }

    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    func customs(){
        view.backgroundColor = IColor.hexStrToColor(hex: "#F5F5F8")
        tableView.backgroundColor = view.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardTVC", bundle: nil), forCellReuseIdentifier: "CardTVC")
    }

}


extension CardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTVC", for: indexPath) as! CardTVC
        cell.updateCell(name: product[indexPath.row].name, cost: "\(product[indexPath.row].cost)", image: product[indexPath.row].photo.first ?? "")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "") { act, viewAction, _ in
            
        }
        
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.product.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        delete.backgroundColor = view.backgroundColor
        delete.image = UIImage(named: "el2")
        
        action.backgroundColor = view.backgroundColor
        action.image = UIImage(named: "el1")
        
        let swipe = UISwipeActionsConfiguration(actions: [action, delete])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedProductVC(nibName: "SelectedProductVC", bundle: nil)
        vc.data = product[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
}


extension CardVC {
    
    func reloadProducts(){
        API.foods { [self] data in
            for d in data {
                product.append(d)
            }
            tableView.reloadData()
        }
        API.drinks { [self] data in
            for d in data {
                product.append(d)
            }
            tableView.reloadData()
        }
        API.snacks { [self] data in
            for d in data {
                product.append(d)
            }
            tableView.reloadData()
        }
        API.souces { [self] data in
            for d in data {
                product.append(d)
            }
            tableView.reloadData()
        }
    }
}
