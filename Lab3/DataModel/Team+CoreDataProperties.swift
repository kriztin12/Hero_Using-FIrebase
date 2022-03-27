//
//  Team+CoreDataProperties.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 27/3/2022.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String?
    @NSManaged public var heroes: NSSet?

}

// MARK: Generated accessors for heroes
extension Team {

    @objc(addHeroesObject:)
    @NSManaged public func addToHeroes(_ value: Superhero)

    @objc(removeHeroesObject:)
    @NSManaged public func removeFromHeroes(_ value: Superhero)

    @objc(addHeroes:)
    @NSManaged public func addToHeroes(_ values: NSSet)

    @objc(removeHeroes:)
    @NSManaged public func removeFromHeroes(_ values: NSSet)

}

extension Team : Identifiable {

}
