//
//  BasketTableViewCell.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/25/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

protocol BasketViewCellDelegate {
    func costReceived(cost: Double)
}

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var delegate: BasketViewCellDelegate?
    var cost: Double!
    var count: Int!
    var calories: Double!
    var categorieKind: CategorieKind!
    var indexPath: IndexPath!
    var finalCost: Double!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        updOutlets()
    }
    
    func updOutlets() {
        
        if BasketService.shared.array.count != 0 {
            finalCost = (Double(count) * cost).rounded(place: 2)
            costLabel.text = String(finalCost) + " Br."
            caloriesLabel.text = String(calories) + categorieKind.caloriesType
            countLabel.text = String(count)
        }
    }
    
    func changeFinalCost(with cost: Double, bool: Bool) {
        let plusCost = cost.rounded(place: 2)
        if bool == true {
            delegate?.costReceived(cost: plusCost)
        } else {
            delegate?.costReceived(cost: -plusCost)
        }
    }
    
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func minusAction(_ sender: UIButton) {
        
        if count == 2  {
            count -= 1
            BasketService.shared.array[indexPath.row].countProducts -= 1
            countLabel.text = String(count)
            minusButton.isEnabled = false
            
            updOutlets()
            changeFinalCost(with: cost, bool: false)


        } else if count > 1 {
            count -= 1
            BasketService.shared.array[indexPath.row].countProducts -= 1
            countLabel.text = String(count)
            plusButton.isEnabled = true
            
            updOutlets()
            changeFinalCost(with: cost, bool: false)

        }
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        
        if count == 9 {
            count += 1
            BasketService.shared.array[indexPath.row].countProducts += 1
            countLabel.text = String(count)
            plusButton.isEnabled = false
            
            updOutlets()
            changeFinalCost(with: cost, bool: true)


        } else if count < 10 {
            count += 1
            BasketService.shared.array[indexPath.row].countProducts += 1
            countLabel.text = String(count)
            minusButton.isEnabled = true
            
            updOutlets()
            changeFinalCost(with: cost, bool: true)
           
        }
    }
    
}
