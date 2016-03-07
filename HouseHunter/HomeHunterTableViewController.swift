//
//  HomeHunterTableViewController.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 29/02/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit
import CoreLocation

class HomeHunterTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var homes:[Home] = []
    var firstTime:Bool = true
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupLocations()
        setupData()
    }
    //MARK:Locations
    func setupLocations() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:Data
    func setupData() {
        if firstTime {
            firstTime = false
            if let savedHomes = loadHomes() {
                homes = savedHomes
            } else {
                homes = loadSampleHomes()
            }
            tableView.reloadData()
        } else {
            tableView.reloadData()
            saveHomes()
        }
    }
    func loadSampleHomes()->[Home] {
        return [
            Home(notes: "Bit scary", address: "Elm St", rating: 1, longitude: -118.3578540, latitude: 34.0970810),
            Home(notes: "4 weird guys hanging around", address: "Abbey Rd", rating: 6, longitude: -0.1830030, latitude: 51.5367910),
            Home(notes: "Close to the river", address: "Beale St", rating: 7, longitude: -90.0457910, latitude: 35.1389400),
            Home(notes: "Nice but a bit noisy", address: "42nd St", rating: 5, longitude: -73.9917030, latitude: 40.7580340)
        ]
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homes.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("home", forIndexPath: indexPath)
        
        cell.textLabel?.text = homes[indexPath.row].address
        cell.detailTextLabel?.text = homes[indexPath.row].notes
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            homes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveHomes()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            if let destinationViewController = segue.destinationViewController as? HomeDetailTableViewController {
                destinationViewController.home = homes[selectedRow.row]
            }
        }
    }
    
    @IBAction func createHome(sender: AnyObject) {
        let latitude = currentLocation?.coordinate.latitude ?? 40.7580340
        let longitude = currentLocation?.coordinate.longitude ?? -73.9917030
        let home = Home(notes: "New Home", address: "", rating: 0, longitude: longitude, latitude: latitude)
        self.homes.append(home)
        let newIndexPath = NSIndexPath(forRow: self.homes.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        
        self.tableView.selectRowAtIndexPath(newIndexPath, animated: true, scrollPosition: .None)
        self.performSegueWithIdentifier("editSegue", sender: self)
    }
    // MARK: NSCoding
    func saveHomes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(homes, toFile: Home.HomesDirectory.path!)
        print(isSuccessfulSave ? "Successful save" : "Save Failed")
    }
    
    func loadHomes() -> [Home]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Home.HomesDirectory.path!) as? [Home]
    }
}
