//
//  FoodCollectionViewCell.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/3/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageVIew: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ingridientsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var categorieKind: CategorieKind!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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

    
}
