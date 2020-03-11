//
//  PurchaseHistory+CoreDataProperties.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//
//

import Foundation
import CoreData


extension PurchaseHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseHistory> {
        return NSFetchRequest<PurchaseHistory>(entityName: "PurchaseHistory")
    }

    @NSManaged public var currentDate: Date?
    @NSManaged public var finalCost: Double
    @NSManaged public var info: NSSet?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for info
extension PurchaseHistory {

    @objc(addInfoObject:)
    @NSManaged public func addToInfo(_ value: Info)

    @objc(removeInfoObject:)
    @NSManaged public func removeFromInfo(_ value: Info)

    @objc(addInfo:)
    @NSManaged public func addToInfo(_ values: NSSet)

    @objc(removeInfo:)
    @NSManaged public func removeFromInfo(_ values: NSSet)

}

// MARK: Generated accessors for order
extension PurchaseHistory {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}
