//
//  MapViewController.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 7/03/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var homes:[Home] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let savedHomes = loadHomes() {
            homes = savedHomes
        }
        mapView.showAnnotations(homes, animated: true)
        displayHomeAnnotations()
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Home {
            var pinAnnotationView:MKPinAnnotationView
            if let dequeuedPinAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("home") as? MKPinAnnotationView {
                pinAnnotationView = dequeuedPinAnnotationView
                pinAnnotationView.annotation = annotation
            } else {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "home")
                pinAnnotationView.canShowCallout = true
            }
            return pinAnnotationView
        }
        return nil
    }
    func displayHomeAnnotations() {
        for home in homes {
            mapView.addAnnotation(home)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadHomes() -> [Home]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Home.HomesDirectory.path!) as? [Home]
    }
}
