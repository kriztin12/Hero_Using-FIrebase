//
//  Superhero+CoreDataProperties.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 27/3/2022.
//
//

import Foundation
import CoreData


extension Superhero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Superhero> {
        return NSFetchRequest<Superhero>(entityName: "Superhero")
    }

    @NSManaged public var abilities: String?
    @NSManaged public var name: String?
    @NSManaged public var universe: Int32
    @NSManaged public var teams: NSSet?

}

// MARK: Generated accessors for teams
extension Superhero {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Team)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Team)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}

extension Superhero : Identifiable {

}
