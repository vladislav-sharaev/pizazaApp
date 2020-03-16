//
//  BasketViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/5/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit




class BasketViewController: UIViewController {
    
    let cellId = "BasketTableViewCell"
    var bskFinalCost = 0.0
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var finalCostLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var goToCategoriesButton: UIButton!
    @IBOutlet weak var emptyBasketImageView: UIImageView!
    @IBOutlet weak var emptyBasketLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uprgradeUIElements()
        title = "Корзина"
        tableView.isHidden = true
        if BasketService.shared.array.count != 0 {
            addTableView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if BasketService.shared.array.count != 0 {
            addTableView()
            makeHideIfEmpty(empty: false)
            tableView.isHidden = false
            addView.isHidden = false
            checkoutButton.isEnabled = true
            tableView.reloadData()
        }
        
        if BasketService.shared.array.count == 0 {
            makeHideIfEmpty(empty: true)
            tableView.isHidden = true
            addView.isHidden = true
            checkoutButton.isEnabled = false
        }
    }
    
    func uprgradeUIElements() {
        goToCategoriesButton.layer.cornerRadius = goToCategoriesButton.frame.height / 2
        goToCategoriesButton.clipsToBounds = true
        goToCategoriesButton.layer.masksToBounds = true
    }
    
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeHideIfEmpty(empty: Bool) {
        if empty == true {
            emptyBasketLabel.isHidden = false
            emptyBasketImageView.isHidden = false
            goToCategoriesButton.isHidden = false
            
        } else {
            emptyBasketLabel.isHidden = true
            emptyBasketImageView.isHidden = true
            goToCategoriesButton.isHidden = true
        }
        
    }
    
    func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func goToCategoriesBtnAction(_ sender: UIButton) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func checkout(_ sender: UIButton) {
    }
    
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if BasketService.shared.array.count == 0 {
            return 1
        } else { return BasketService.shared.array.count}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BasketTableViewCell
        if BasketService.shared.array.count != 0 {
            
            cell.costLabel.text = String(BasketService.shared.array[indexPath.row].cost)
            cell.categorieKind = BasketService.shared.array[indexPath.row].categorieKind
            cell.calories = BasketService.shared.array[indexPath.row].calories
            cell.count = BasketService.shared.array[indexPath.row].countProducts
            cell.cost = BasketService.shared.array[indexPath.row].cost.rounded(place: 2)
            cell.productImageView.image = BasketService.shared.array[indexPath.row].picture
            cell.nameLabel.text = BasketService.shared.array[indexPath.row].name
            cell.indexPath = indexPath
            
            bskFinalCost = BasketService.shared.getFinalCost().rounded(place: 2)
            self.finalCostLabel.text = String(bskFinalCost) + " Br."
            cell.delegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if BasketService.shared.array.count != 1 {
                BasketService.shared.deleteElement(index: indexPath.row)
                bskFinalCost = BasketService.shared.getFinalCost().rounded(place: 2)
                self.finalCostLabel.text = String(bskFinalCost) + " Br."
                tableView.deleteRows(at: [indexPath], with: .fade)
                if let tabItems = tabBarController?.tabBar.items {
                    let tabItem = tabItems[1]
                    tabItem.badgeValue = String(BasketService.shared.array.count)
                }
            } else {
                showAlert(title: "Товар не удален!", message: "Преждем чем удалить единственный товар из корзины, добавьте в нее что-нибудь еще.")
            }                
        }
    }
    
}

extension BasketViewController: BasketViewCellDelegate {
    func costReceived(cost: Double) {
        bskFinalCost += cost.rounded(place: 2)
        bskFinalCost = bskFinalCost.rounded(place: 2)
        self.finalCostLabel.text = String(bskFinalCost) + " Br."
    }
}

