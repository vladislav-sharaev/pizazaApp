//
//  OneProductCollectionViewCell.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/4/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class OneProductCollectionViewCell: UICollectionViewCell {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    /*
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
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
            self.oneProductCostLabel.text = String(costMin * Double(sender.value)) + " Br"
        } else {
            finalCost = costMax! * stepper.value
            self.oneProductCostLabel.text = String(costMax! * Double(sender.value)) + " Br"
        }
    }
    @IBAction func caloriesSegmentedControlAction(_ sender: UISegmentedControl) {
        if caloriesSegmentedControl.selectedSegmentIndex == 0 {
            finalCost = costMin * stepper.value
            self.oneProductCostLabel.text = String(finalCost) + " Br"
        } else {
            finalCost = costMax! * stepper.value
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
                        i.finalCost += finalCost
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
            BasketService.shared.addNewElement(basketElement: BasketElement(picture: oneProductImageView.image!, name: oneProductNameLabel.text!, countProducts: Int(stepper.value), finalCost: finalCost, calories: getCalories()))
            showAlert(title: "Товар добавлен!", message: "Вернитесь назад и добавьте чего-нибудь еще :) ")
        }
        
    }
    */
}
