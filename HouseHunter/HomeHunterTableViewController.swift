//
//  HomeHunterTableViewController.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 7/03/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit

class HomeHunterTableViewController: UITableViewController {

    var homes:[Home] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedHomes = loadHomes() {
            homes = savedHomes
        } else {
            homes = loadSampleHomes()
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        saveHomes()
    }
    func loadSampleHomes()->[Home] {
        return [
            Home(notes: "Bit scary", address: "Elm St", rating: 1),
            Home(notes: "4 weird guys hanging around", address: "Abbey Rd", rating: 6),
            Home(notes: "Close to the river", address: "Beale St", rating: 7),
            Home(notes: "Nice but a bit noisy", address: "42nd St", rating: 5)
        ]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("home", forIndexPath: indexPath)
        cell.textLabel!.text = homes[indexPath.row].address
        cell.detailTextLabel!.text = homes[indexPath.row].notes
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            homes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveHomes()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    @IBAction func createHome(sender: AnyObject) {
        let home = Home(notes: "New Home", address: "", rating: 0)
        self.homes.append(home)
        let newIndexPath = NSIndexPath(forRow: self.homes.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        
        self.tableView.selectRowAtIndexPath(newIndexPath, animated: true, scrollPosition: .None)
        self.performSegueWithIdentifier("editSegue", sender: self)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            if let destinationViewController = segue.destinationViewController as? HomeDetailTableViewController {
                destinationViewController.home = homes[selectedRow.row]
            }
        }
    }
    //MARK: NSCoding
    func saveHomes() {
        var isSuccessfulSave = false
        if let path = Home.HomesDirectory.path {
            isSuccessfulSave = NSKeyedArchiver.archiveRootObject(homes, toFile: path)
        }
        print(isSuccessfulSave ? "Successful save" : "Save Failed")
    }
    func loadHomes()->[Home]? {
        if let path = Home.HomesDirectory.path {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Home]
        }
        return nil
    }
}
