//
//  Superhero.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 16/4/2022.
//

import UIKit
import FirebaseFirestoreSwift

enum CodingKeys: String, CodingKey{
    case id
    case name
    case abilities
    case universe
}

enum Universe: Int {
    case marvel = 0
    case dc = 1
}

class Superhero: NSObject, Codable {
    @DocumentID var id: String?
    var name: String?
    var abilities: String?
    var universe: Int?
    
}

extension Superhero{
    var herouniverse: Universe{
        get{
            return Universe(rawValue: self.universe!)!
        }
        set{
            self.universe = newValue.rawValue
        }
    }
}
