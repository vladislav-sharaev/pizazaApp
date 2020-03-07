//
//  Categories.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 2/2/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

enum CategorieKind {
    case pizza
    case drink
    case candy
    
    var title: String {
        switch self {
        case .pizza:
            return "Пицца"
        case .drink:
            return "Напитки"
        case .candy:
            return "Десерты"
        }
    }
    
    var caloriesType: String {
        switch self {
        case .drink:
            return " л."
        default:
            return " кг."
        }
    }
   
}

class Categories {
    let name: String
    let image: UIImage
    let kind: CategorieKind
    
    init(name: String, image: UIImage, kind: CategorieKind) {
        self.name = name
        self.image = image
        self.kind = kind
    }
}
