//
//  DoubleException.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/1/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

extension Double {
    func rounded(place: Int) -> Double {
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
    }
}

/*
 func rounded(place: Double) -> Double {
     let str = String(format: "%.2f", place)
     return Double(str)!
 }
 */
