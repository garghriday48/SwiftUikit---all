//
//  Employee+CoreDataProperties.swift
//  coreData
//
//  Created by Pragath on 09/03/23.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID
    @NSManaged public var name: String?

}

extension Employee : Identifiable {

}
