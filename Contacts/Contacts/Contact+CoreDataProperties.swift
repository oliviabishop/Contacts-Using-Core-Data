//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Olivia Bishop on 4/26/18.
//  Copyright © 2018 Olivia Bishop. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?

}
