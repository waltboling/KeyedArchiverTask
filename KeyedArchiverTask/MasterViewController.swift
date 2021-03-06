//
//  MasterViewController.swift
//  KeyedArchiverTask
//
//  Created by Jon Boling on 4/30/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Teams]()
    
    let city = ["Los Angeles", "Miami", "New York", "Nashville", "Baltimore"]
    let teamName = ["Bears", "Tigers", "Eagles", "Pirates", "Cyclones"]
    var colorOne = [UIColor.blue, UIColor.red, UIColor.orange, UIColor.purple, UIColor.green]
    var colorTwo = [UIColor.black, UIColor.white, UIColor.lightGray, UIColor.darkGray, UIColor.yellow]
    var mascot = [#imageLiteral(resourceName: "Bears"), #imageLiteral(resourceName: "Tigers"), #imageLiteral(resourceName: "Eagles"), #imageLiteral(resourceName: "Pirates"), #imageLiteral(resourceName: "Cyclones")]
    
    var filePath: String? {
        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let savePath = documentDirectory.appendingPathComponent("teams.bin")
            return savePath.path
        } catch {
            print("Error getting path")
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        if let path = filePath {
            if let array = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Teams] {
                objects = array
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let randomCity = city[Int(arc4random_uniform(UInt32(city.count)))]
        let teamSelection = Int(arc4random_uniform(UInt32(teamName.count)))
        let randomTeamName = teamName[teamSelection]
        let randomColorOne = colorOne[Int(arc4random_uniform(UInt32(colorOne.count)))]
        let randomColorTwo = colorTwo[Int(arc4random_uniform(UInt32(colorTwo.count)))]
        let teamMascot = mascot[teamSelection]
        
        objects.insert(Teams(city: randomCity, teamName: randomTeamName, colorOne: randomColorOne, colorTwo: randomColorTwo, mascot: teamMascot), at: 0)
        if let path = filePath {
            NSKeyedArchiver.archiveRootObject(objects, toFile: path)
        }
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] 
        cell.textLabel!.text = object.title
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            if let path = filePath {
                NSKeyedArchiver.archiveRootObject(objects, toFile: path)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

