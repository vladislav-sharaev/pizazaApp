//
//  CategoriesModel.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

class CategoriesModel {
    var categories = [Categories]()    
    
    init() {
        setUp()
    }
    
    func setUp() {
        let pizzaCategorie = Categories(name: "Pizza", image: UIImage(named: "pizzaCategorie")!, kind: .pizza)
        let drinkCategorie = Categories(name: "Drink", image: UIImage(named: "drinkCategorie")!, kind: .drink)
        let candyCategorie = Categories(name: "Candy", image: UIImage(named: "candyCategorie")!, kind: .candy)
        
        categories.append(pizzaCategorie)
        categories.append(drinkCategorie)
        categories.append(candyCategorie)
        
    }
}
