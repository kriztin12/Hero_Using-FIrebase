//
//  CurrentPartyTableViewController.swift
//  Lab3
//
//  Created by Kriztin Abellon on 16/3/2022.
//

import UIKit

class CurrentPartyTableViewController: UITableViewController, DatabaseListener {
    var listenerType: ListenerType = .team
    weak var databaseController: DatabaseProtocol?
    
    func onTeamChange(change: DatabaseChange, teamHeroes: [Superhero]) {
        currentParty = teamHeroes
        tableView.reloadData()
    }
    
    func onAllHeroesChange(change: DatabaseChange, heroes: [Superhero]) {
        // do nothing
    }
    
    
    func addSuperhero(_ newHero: Superhero) -> Bool {
//        if currentParty.count >= 6{
//            return false
//        }
//
//        tableView.performBatchUpdates({
//            currentParty.append(newHero)
//            tableView.insertRows(at: [IndexPath(row: currentParty.count - 1, section: SECTION_HERO)], with: .automatic)
//        }, completion: nil)
//        tableView.reloadSections([SECTION_INFO], with: .automatic)
//        return true
        
        return databaseController?.addHeroToTeam(hero: newHero, team: databaseController!.defaultTeam) ?? false
    }

    // section numbers
    let SECTION_HERO = 0
    let SECTION_INFO = 1
    
    // identifiers used
    let CELL_HERO = "heroCell"
    let CELL_INFO = "partySizeCell"
    
    var currentParty: [Superhero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
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
        // 2 sections so return 2
        return 2
    }

    // determines number of rows in a specified section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // need to return a different value depending on if the section is for our
        // current party or for info section
        switch section {
        case SECTION_INFO:
            return 1
        case SECTION_HERO:
            return currentParty.count
        default:
            return 0
        }
    }

    // creates the cells to be displayed to the user
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // generates the cell object
        // section tells us what kind of cell we need to generate
        // row tells which object should display information for in the cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        // if hero then generate the cells for that
        if indexPath.section == SECTION_HERO {
        // Configure and return a hero cell
            let heroCell = tableView.dequeueReusableCell(withIdentifier: CELL_HERO, for: indexPath)
            
            var content = heroCell.defaultContentConfiguration()
            let hero = currentParty[indexPath.row]
            content.text = hero.name
            content.secondaryText = hero.abilities
            heroCell.contentConfiguration = content
        
            return heroCell
        }
        else {
            // type is generate whatever has been specified with the identifier
            // Configure and return an info cell instead
            let infoCell = tableView.dequeueReusableCell(withIdentifier: CELL_INFO, for: indexPath)
            
            var content = infoCell.defaultContentConfiguration()
            if currentParty.isEmpty {
                content.text = "No Heroes in Party. Tap + to add some."
            } else {
                content.text = "\(currentParty.count)/6 Heroes in Party"
            }
            infoCell.contentConfiguration = content
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
        
        // handles the deletion of rows and only deletes if its a HERO cell
        if editingStyle == .delete && indexPath.section == SECTION_HERO {
            // perform batch updates, these three steps need to be done in a single batch
//            tableView.performBatchUpdates({
//                self.currentParty.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .fade)
//                self.tableView.reloadSections([SECTION_INFO], with: .automatic)
//            }, completion: nil)
            self.databaseController?.removeHeroFromTeam(hero: currentParty[indexPath.row], team: databaseController!.defaultTeam)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
        if segue.identifier == "allHeroesSegue"{
            let destination = segue.destination as! AllHeroesTableViewController
            //destination.superHeroDelegate = self
        }
    }


}
