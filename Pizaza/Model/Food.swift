//
//  Food.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/3/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

class Food {
    let name: String
    let costMin: Double
    let costMax: Double?
    let minCalories: Double
    let maxCalories: Double?
    let url: String
    let ingridients: String?
    let categorie: String

    func getCost() -> String {
        return ("\(costMin) Br")
    }
    
    init(name: String, costMin: Double, costMax: Double?, url: String, minCalories: Double, maxCalories: Double?, ingridients: String?, categorie: String) {
        self.name = name
        self.costMin = costMin
        self.costMax = costMax
        self.url = url
        self.minCalories = minCalories
        self.maxCalories = maxCalories
        self.ingridients = ingridients
        self.categorie = categorie
    }
}

