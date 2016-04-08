//
//  MapViewController.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 8/04/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var homes:[Home] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let savedHomes = loadHomes() {
            homes = savedHomes
        }
        mapView.showAnnotations(homes, animated: true)
        for home in homes {
            mapView.addAnnotation(home)
        }
        mapView.reloadInputViews()
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Home {
            var pin:MKPinAnnotationView
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "home")
            pin.canShowCallout = true
            return pin
        }
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadHomes()->[Home]? {
        if let path = Home.HomesDirectory.path {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Home]
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
