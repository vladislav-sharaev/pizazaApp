//
//  BasketElement.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/4/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

class BasketElement {
    var picture: UIImage
    var name: String
    var countProducts: Int
    var cost: Double
    var calories: Double
    var categorieKind: CategorieKind
    init(picture: UIImage, name: String, countProducts: Int, cost: Double, calories: Double, categorieKind: CategorieKind) {
        self.picture = picture
        self.name = name
        self.countProducts = countProducts
        self.cost = cost
        self.calories = calories
        self.categorieKind = categorieKind
    }
}

