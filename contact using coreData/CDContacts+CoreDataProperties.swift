//
//  CDContacts+CoreDataProperties.swift
//  contact
//
//  Created by Pragath on 14/03/23.
//
//

import Foundation
import CoreData


extension CDContacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContacts> {
        return NSFetchRequest<CDContacts>(entityName: "CDContacts")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var phnNumber: [String]?
    @NSManaged public var secondName: String?
    @NSManaged public var id: Int64

}

extension CDContacts : Identifiable {

}
