//
//  AllHeroesTableViewController.swift
//  Lab3
//
//  Created by Kriztin Abellon on 21/3/2022.
//

import UIKit

class AllHeroesTableViewController: UITableViewController, UISearchResultsUpdating, DatabaseListener {
    func onTeamChange(change: DatabaseChange, teamHeroes: [Superhero]) {
        // do nothing
    }
    
    func onAllHeroesChange(change: DatabaseChange, heroes: [Superhero]) {
        allHeroes = heroes
        updateSearchResults(for: navigationItem.searchController!)
    }
    
    
    var listenerType = ListenerType.heroes
    weak var databaseController: DatabaseProtocol?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        if searchText.count > 0 {
            filteredHeroes = allHeroes.filter({ (hero: Superhero) -> Bool in
                return (hero.name?.lowercased().contains(searchText) ?? false)
            })
        } else{
            filteredHeroes = allHeroes
        }
        tableView.reloadData()
    }
    
    var filteredHeroes: [Superhero] = []

    let SECTION_HERO = 0
    let SECTION_INFO = 1
    
    let heroCell = "heroCell"
    let totalCell = "totalCell"
    
    var allHeroes: [Superhero] = []
    
    // to prevent strong reference cycles
    weak var superHeroDelegate: addSuperheroDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        
        filteredHeroes = allHeroes
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        // tell user to enter a search item
        searchController.searchBar.placeholder = "Search All Heroes"
        navigationItem.searchController = searchController
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // automatically register itself to receive updates from the database when the view is about to appear on screen and deregister itself when its about to disappear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removieListener(listener: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case SECTION_INFO:
            return 1
        case SECTION_HERO:
            return filteredHeroes.count
        default:
            return 0
        }
       
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        // if hero then generate the cells for that
        if indexPath.section == SECTION_HERO {
        // Configure and return a hero cell
            let heroCell = tableView.dequeueReusableCell(withIdentifier: heroCell, for: indexPath)
            
            var content = heroCell.defaultContentConfiguration()
            let hero = filteredHeroes[indexPath.row]
            content.text = hero.name
            content.secondaryText = hero.abilities
            heroCell.contentConfiguration = content
        
            return heroCell
        }
        else {
            // type is generate whatever has been specified with the identifier
            // since custom cell, need to dequeue the cell and then cast it to its correct
            // cell type
            // forced cast = as!
            let infoCell = tableView.dequeueReusableCell(withIdentifier: totalCell, for: indexPath) as! HeroCountTableViewCell
            
            
            infoCell.totalLabel?.text = "\(filteredHeroes.count) heroes in the database"
            return infoCell
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_HERO {
            return true
        }
        else {
            return false
        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_HERO {
            // Delete the row from the data source
//            tableView.performBatchUpdates({
//                // delete row in both allHeroes and filteredHeroes
//                if let index = self.allHeroes.firstIndex(of: filteredHeroes[indexPath.row]){
//                    self.allHeroes.remove(at: index)
//                }
//                self.filteredHeroes.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .fade)
//                self.tableView.reloadSections([SECTION_INFO], with: .automatic)
//            }, completion: nil)
            let hero = filteredHeroes[indexPath.row]
            databaseController?.deleteSuperhero(hero: hero)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // method allows us to provide behaviour for when the user selects a row within the Table View.
    // only work if selection of the cell is enabled
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = filteredHeroes[indexPath.row]
        let heroAdded = databaseController?.addHeroToTeam(hero: hero, team: databaseController!.defaultTeam) ?? false
        
        if heroAdded {
            navigationController?.popViewController(animated: false)
            return
        }
        
//        if let superHeroDelegate = superHeroDelegate {
//            if superHeroDelegate.addSuperhero(filteredHeroes[indexPath.row]) {
//                navigationController?.popViewController(animated: false)
//                return
//            }
//            else{
//                displayMessage(title: "Party Full", message: "Unable to add more members to the party")
//            }
//        }
        displayMessage(title: "Party Full", message: "Unable to add more members to the party")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // display message function (ALERT function)
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "createHeroSegue" {
            let destination = segue.destination as! CreateHeroViewController
            // destination.superHeroDelegate = self
        }
    }
    

}
