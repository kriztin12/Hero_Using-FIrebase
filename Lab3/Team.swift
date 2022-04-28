//
//  Team.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 16/4/2022.
//

import UIKit
import FirebaseFirestoreSwift

class Team: NSObject, Codable {
    @DocumentID var id: String?
    var name: String?
    var heroes = [Superhero]()
    
}
