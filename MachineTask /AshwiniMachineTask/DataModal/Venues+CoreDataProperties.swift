//
//  Venues+CoreDataProperties.swift
//  AshwiniMachineTask
//


import Foundation
import CoreData


extension Venues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venues> {
        return NSFetchRequest<Venues>(entityName: "Venues")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?

}
