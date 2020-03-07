//
//  FoodModel.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/3/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

class FoodModel {
    
    //MARK: For pizza
    var urlForPizza = [     "https://app.pzzby.com/uploads/photos/ZTfcVp8zRT.jpg",
                            "https://app.pzzby.com/uploads/photos/fBtDpsJb4u.jpg",
                            "https://app.pzzby.com/uploads/photos/dlf2Bv8dDm.jpg",
                            "https://app.pzzby.com/uploads/photos/e2llMCLKhy.jpg",
                            "https://app.pzzby.com/uploads/photos/wPBXtTIyJo.jpg"]
    var namesForPizza = ["Пеперони и болгарский перец",
                         "Кантри четыре сезона",
                         "Баварский цыпленок",
                         "Ранч пицца",
                         "Гавайская"]
    var minCostForPizza = [12.9, 12.9, 12.9, 12.9, 10.9]
    var maxCostForPizza = [17.9, 17.9, 17.9, 17.9, 15.9]
    var ingridientsForPizza = [
        "Пицца-соус, пепперони, свежий болгарский перец, сыр моцарелла, базилик",
        "Грибной соус, буженина (свинина), грудинка (свинина), маринованные опята, сыр фета, сыр дорблю, сыр моцарелла, базилик",
        "Сладкий горчичный соус, грудинка (свинина), филе цыпленка, свежий болгарский перец, маслины, сыр моцарелла, базилик",
        "Американский соус ранч, филе цыпленка, ветчина, свежие томаты, сыр моцарелла, базилик",
        "Сырный соус, ветчина, филе цыпленка, ананасы, сыр моцарелла, базилик"
    ]
    var minCaloriesForPizza = [0.6, 0.6, 0.6, 0.6, 0.5]
    var maxCaloriesForPizza = [0.9, 0.9, 0.9, 0.9, 0.8]
    var pizzaContainer = [Food]()
    
    func setUpPizza() {
        
        for index in 0 ..< urlForPizza.count {
            let somePizza = Food(name: namesForPizza[index], costMin: minCostForPizza[index], costMax: maxCostForPizza[index], url: urlForPizza[index], minCalories: minCaloriesForPizza[index], maxCalories: maxCaloriesForPizza[index], ingridients: ingridientsForPizza[index])
            pizzaContainer.append(somePizza)
        }
        pizzaContainer.reverse()
    }
    
    //MARK: For drink
    var urlForDrink = [     "https://app.pzzby.com/uploads/photos/rBesjdx1X4.jpg",
                            "https://app.pzzby.com/uploads/photos/huJpDOvy7k.jpg",
                            "https://app.pzzby.com/uploads/photos/8J5RKaMXKj.jpg",
                            "https://app.pzzby.com/uploads/photos/q2JUlOH65u.jpg",
                            "https://app.pzzby.com/uploads/photos/dFlQKx0nJb.jpg"]
    var namesForDrink = ["Coca-cola",
                         "Fanta",
                         "Sprite",
                         "Fuzetea Лесные ягоды-гибискус",
                         "BonAqua Негаз."]
    var minCostForDrink = [1.9, 1.9, 1.9, 2.9, 1.9]
    var maxCostForDrink = [nil, nil, nil, 4.0, nil] as [Double?]
    var ingridientsForDrink = [
        nil,
        nil,
        nil,
        "Лесные ягоды и мята",
        nil]
    var minCaloriesForDrink = [0.5, 0.5, 0.5, 0.9, 0.5]
    var maxCaloriesForDrink = [nil, nil, nil, 2.0, nil] as [Double?]
    var drinkContainer = [Food]()
    
    func setUpDrink() {
        for index in 0 ..< urlForDrink.count {
            let someDrink = Food(name: namesForDrink[index], costMin: minCostForDrink[index], costMax: maxCostForDrink[index], url: urlForDrink[index], minCalories: minCaloriesForDrink[index], maxCalories: maxCaloriesForDrink[index], ingridients: ingridientsForDrink[index])
            drinkContainer.append(someDrink)
        }
        drinkContainer.reverse()
    }
    
    //MARK: For candy
    var urlForCandy = [     "https://app.pzzby.com/uploads/photos/1qcmctszYa.jpg",
                            "https://app.pzzby.com/uploads/photos/nkzfsJuJIu.jpg",
                            "https://app.pzzby.com/uploads/photos/ZG8puO38hR.jpg"]
    var namesForCandy = ["Шоколадный торт",
                         "Медовик",
                         "Шоколадный чизкейк"]
    var minCostForCandy = [5.50, 5.50, 5.50, 5.50, 5.50]
    var maxCostForCandy = [nil, nil, 10.0, nil, nil] as [Double?]
    var ingridientsForCandy = [
        "Шоколад внутри и снаружи",
        nil,
        nil]
    var minCaloriesForCandy = [0.11, 0.11, 0.11]
    var maxCaloriesForCandy = [nil, nil, 0.25] as [Double?]
    var candyContainer = [Food]()
    
    func setUpCandy() {
        for index in 0 ..< urlForCandy.count {
            let someCandy = Food(name: namesForCandy[index], costMin: minCostForCandy[index], costMax: maxCostForCandy[index], url: urlForCandy[index], minCalories: minCaloriesForCandy[index], maxCalories: maxCaloriesForCandy[index], ingridients: ingridientsForCandy[index])
            candyContainer.append(someCandy)
        }
        candyContainer.reverse()
    }
    
    //MARK: init
    var picture = UIImage(named: "pizzaCategorie")
    init() {
        setUpPizza()
        setUpDrink()
        setUpCandy()
    }
}
