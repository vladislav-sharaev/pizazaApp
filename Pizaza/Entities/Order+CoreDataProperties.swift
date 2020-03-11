//
//  Order+CoreDataProperties.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var calories: Double
    @NSManaged public var cost: Double
    @NSManaged public var count: Int16
    @NSManaged public var name: String?
    @NSManaged public var picture: Data?
    @NSManaged public var caloriesType: String?
    @NSManaged public var purchaseHistory: PurchaseHistory?

}
