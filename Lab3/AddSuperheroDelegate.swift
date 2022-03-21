//
//  AddSuperheroDelegate.swift
//  Lab3
//
//  Created by Kriztin Abellon on 21/3/2022.
//

import Foundation


protocol addSuperheroDelegate: AnyObject{
    func addSuperhero(_ newHero: Superhero) -> Bool
}
