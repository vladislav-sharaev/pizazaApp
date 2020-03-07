//
//  BasketService.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/4/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

class BasketService {
    static var shared = BasketService()
    var array = [BasketElement]()
    
    func addNewElement(basketElement: BasketElement) {
        BasketService.shared.array.append(basketElement)
    }
    
    func deleteElement(index: Int) {
        BasketService.shared.array.remove(at: index)
    }
    
    func getFinalCost() -> Double {
        var finalCost: Double = 0
        for element in BasketService.shared.array {
            let cost = element.cost * Double(element.countProducts)
            finalCost += cost.rounded(place: 2)
            
        }
        return finalCost
    }
}
