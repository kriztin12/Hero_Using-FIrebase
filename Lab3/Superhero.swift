//
//  Superhero.swift
//  Lab3
//
//  Created by Kriztin Abellon on 16/3/2022.
//

import UIKit

class Superhero: NSObject {
    var name: String?
    var abilities: String?
    var universe: Universe?
    
    enum Universe: Int{
        case marvel = 0
        case dc = 1
    }
    
    init(name: String?, abilities: String?, universe: Universe?) {
        self.name = name
        self.abilities = abilities
        self.universe = universe
    }
}