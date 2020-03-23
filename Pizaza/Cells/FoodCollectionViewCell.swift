//
//  FoodCollectionViewCell.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/3/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import Firebase

protocol FoodCollectionViewCellDelegate {
    func needUpdate(update: Bool)
}

class FoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageVIew: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ingridientsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var delegate: FoodCollectionViewCellDelegate?
    var indexPath: IndexPath!
    var categorieKindText = ""
    var categorieKind: CategorieKind!
    var food: Food!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if categorieKind == .drink {
            categorieKindText = "drink"
        } else if categorieKind == .pizza {
            categorieKindText = "pizza"
        } else {
            categorieKindText = "candy"
        }
        for element in Helper.helper.likedFood {
            if food.name == element.name {
                likeButton.setImage(UIImage(named: "dislike"), for: .normal)
            } 
        }
        hideOutlets()
    }
    
    func hideOutlets() {
        switch self.categorieKind {
        case .pizza:
            //ingridientsLabel.isHidden = false
            break
        case .drink:
            ingridientsLabel.isHidden = true
            break
        case .candy:
            ingridientsLabel.isHidden = false
            break
        case .none:
            break
        }
    }
    
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xopowo", style: .cancel, handler: nil))
    }
    
    @IBAction func likeBtnAction(_ sender: UIButton) {
        print("Like btn tapped")
        
        if Auth.auth().currentUser != nil {
            let foodData = ["name": food.name,
                            "minCalories": food.minCalories,
                            "maxCalories": food.maxCalories,
                            "costMin": food.costMin,
                            "costMax": food.costMax,
                            "ingridients": food.ingridients,
                            "url": food.url,
                            "categorieKindText": categorieKindText
            ] as [String : Any]
            
            var added = false
            var counter = 0
            for element in Helper.helper.likedFood {
                if element.name == food.name {
                    Helper.root.document("\(element.name)").delete() { error in
                        if let error = error {
                            print("Removing error", error)
                        } else {
                            print("Delete success")
                        }
                    }
                    Helper.helper.likedFood.remove(at: counter)
                    self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                    self.delegate?.needUpdate(update: true)
                    added = true
                    
                }
                counter += 1
                
            }
            if added == false {
                Helper.root.document(foodData["name"] as! String).setData(foodData, merge: true) { (error) in
                    if let error = error {
                        print("Some set error ", error)
                    }
                    
                }
                self.likeButton.setImage(UIImage(named: "dslike"), for: .normal)
                Helper.helper.likedFood.append(self.food)
            }
        } else {
            showAlert(title: "Войдите в аккаунт", message: "Прежде чем добавить товар в избранные, вам нужно войти в аккаунт")
        }
        
    }
    
}
