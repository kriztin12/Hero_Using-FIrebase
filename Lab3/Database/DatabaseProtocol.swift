//
//  DatabaseProtocol.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 27/3/2022.
//

import Foundation

enum DatabaseChange{
    case add
    case remove
    case update
}

enum ListenerType{
    case team
    case heroes
    case all
}

protocol DatabaseListener: AnyObject{
    var listenerType: ListenerType{get set}
    func onTeamChange(change: DatabaseChange, teamHeroes: [Superhero])
    func onAllHeroesChange(change: DatabaseChange, heroes: [Superhero])
}

protocol DatabaseProtocol: AnyObject{
    func cleanup()
    
    func addListener(listener: DatabaseListener)
    func removieListener(listener: DatabaseListener)
    
    func addSuperhero(name: String, abilities: String, universe: Universe) -> Superhero
    func deleteSuperhero(hero: Superhero)
    
    var defaultTeam: Team {get}
    
    func addTeam(teamName: String) -> Team
    func deleteTeam(team: Team)
    func addHeroToTeam(hero: Superhero, team: Team) -> Bool
    func removeHeroFromTeam(hero: Superhero, team: Team)
}
