//
//  Entity+CoreDataProperties.swift
//  Essbio
//
//  Created by Matias Villagran on 19-01-18.
//  Copyright © 2018 Matias Villagran. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}
