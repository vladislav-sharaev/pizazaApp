//
//  Info+CoreDataProperties.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/10/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//
//

import Foundation
import CoreData


extension Info {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Info> {
        return NSFetchRequest<Info>(entityName: "Info")
    }

    @NSManaged public var adress: String?
    @NSManaged public var code: String?
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?
    @NSManaged public var floor: String?
    @NSManaged public var name: String?
    @NSManaged public var porch: String?
    @NSManaged public var room: String?
    @NSManaged public var telephone: String?
    @NSManaged public var purchaseHistory: PurchaseHistory?

}
