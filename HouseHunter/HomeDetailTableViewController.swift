//
//  HomeDetailTableViewController.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 29/02/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit


class HomeDetailTableViewController: UITableViewController {
    @IBOutlet weak var ratingTitle: UILabel!
    
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    
    var home:Home?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let home = home {
            notesTextField.text = home.notes
            addressTextField.text = home.address
            ratingSlider.value = home.rating
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func homeChanged(sender: AnyObject) {
        if let home = home {
            if let notes = notesTextField.text {
                home.notes = notes
            }
            if let address = addressTextField.text {
                home.address = address
            }
            home.rating = ratingSlider.value
        }
        ratingTitle.text = "Rating: \(Int(ratingSlider.value))"
    }
    
}
