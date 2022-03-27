//
//  Superhero+CoreDataClass.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 27/3/2022.
//
//

import Foundation
import CoreData

enum Universe : Int32 {
    case marvel = 0
    case dc = 1
}

@objc(Superhero)
public class Superhero: NSManagedObject {
    
}

extension Superhero{
    var herouniverse: Universe{
        get{
            return Universe(rawValue: self.universe)!
        }
        set{
            self.universe = newValue.rawValue
        }
    }
}
