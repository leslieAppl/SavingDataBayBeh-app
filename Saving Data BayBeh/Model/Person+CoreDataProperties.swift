//
//  Person+CoreDataProperties.swift
//  Saving Data BayBeh
//
//  Created by leslie on 10/2/19.
//  Copyright © 2019 leslie. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
