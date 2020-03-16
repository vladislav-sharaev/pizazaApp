//
//  CellProductViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/28/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class CellProductViewController: UIViewController {

    @IBOutlet weak var oneProductImageView: UIImageView!  
    @IBOutlet weak var oneProductNameLabel: UILabel!
    @IBOutlet weak var oneProductIngridientsLabel: UILabel!
    @IBOutlet weak var oneProductCostLabel: UILabel!
    @IBOutlet weak var countOfProductLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var caloriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    var caloriesMin: Double!
    var caloriesMax: Double?
    var usableCalories: Double?
    var costMin: Double!
    var costMax: Double?
    var finalCost: Double!
    var categoreiKind: CategorieKind!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCalories() -> Double {
        if caloriesSegmentedControl.selectedSegmentIndex == 0 {
            return caloriesMin
        } else { return caloriesMax! }
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        
        countOfProductLabel.text = String(sender.value)
        if caloriesSegmentedControl.selectedSegmentIndex == 0 {
            finalCost = costMin * stepper.value
            finalCost = finalCost.rounded(place: 2)
            self.oneProductCostLabel.text = String(finalCost) + " Br"

        } else {
            finalCost = costMax! * stepper.value
            finalCost = finalCost.rounded(place: 2)
            self.oneProductCostLabel.text = String(finalCost) + " Br"
        }
    }
    
    @IBAction func caloriesSemgentedControl(_ sender: UISegmentedControl) {
        
        if caloriesSegmentedControl.selectedSegmentIndex == 0 {
            finalCost = costMin * stepper.value
            finalCost = finalCost.rounded(place: 2)
            self.oneProductCostLabel.text = String(finalCost) + " Br"
        } else {
            finalCost = costMax! * stepper.value
            finalCost = finalCost.rounded(place: 2)
            self.oneProductCostLabel.text = String(finalCost) + " Br"
        }
    }
    
    @IBAction func addToBasketAction(_ sender: UIButton) {
        
        var flag = false
        if BasketService.shared.array.count != 0 {
            for i in BasketService.shared.array {
                if i.name == oneProductNameLabel.text && i.calories == getCalories() {
                    let count = i.countProducts + Int(stepper.value)
                    if  count < 11 {
                        i.countProducts += Int(stepper.value)
                        let cost = finalCost / stepper.value
                        i.cost = cost
                        showAlert(title: "Товар добавлен!", message: "Вернитесь назад и добавьте чего-нибудь еще :) ")
                        flag = true
                    } else {
                        showAlert(title: "Товар не добавлен!", message: "Корзина может вмещат в себя не более 10 одинаковых элементов")
                        flag = true
                    }
                   
                }
            }
        }
        if flag == false {
            let cost = finalCost / stepper.value
            BasketService.shared.addNewElement(basketElement: BasketElement(picture: oneProductImageView.image!, name: oneProductNameLabel.text!, countProducts: Int(stepper.value), cost: cost, calories: getCalories(), categorieKind: categoreiKind))
            if let tabItems = tabBarController?.tabBar.items {
                let tabItem = tabItems[1]
                tabItem.badgeValue = String(BasketService.shared.array.count)
            }
            tabBarController?.tabBarItem.badgeValue = String(BasketService.shared.array.count)
            showAlert(title: "Товар добавлен!", message: "Вернитесь назад и добавьте чего-нибудь еще :) ")
        }
    }
    

}

