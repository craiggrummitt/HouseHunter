//
//  Home.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 7/03/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import Foundation
import MapKit

class Home:NSObject, NSCoding {
    var notes:String
    var address:String
    var rating:Float
    var longitude:Double
    var latitude:Double
    
    init(notes:String,address:String,rating:Float,longitude:Double,latitude:Double) {
        self.notes = notes
        self.address = address
        self.rating = rating
        self.longitude = longitude
        self.latitude = latitude
    }
    //MARK: Types
    struct PropertyKey {
        static let notes = "notes"
        static let address = "address"
        static let rating = "rating"
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let HomesDirectory = DocumentsDirectory.URLByAppendingPathComponent("homes")
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.notes, forKey: PropertyKey.notes)
        aCoder.encodeObject(self.address, forKey: PropertyKey.address)
        aCoder.encodeFloat(self.rating, forKey: PropertyKey.rating)
        aCoder.encodeDouble(self.longitude, forKey: PropertyKey.longitude)
        aCoder.encodeDouble(self.latitude, forKey: PropertyKey.latitude)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let notes = aDecoder.decodeObjectForKey(PropertyKey.notes) as? String,
        let address = aDecoder.decodeObjectForKey(PropertyKey.address) as? String
        else {return nil}
        self.init(
            notes: notes,
            address: address,
            rating: aDecoder.decodeFloatForKey(PropertyKey.rating),
            longitude: aDecoder.decodeDoubleForKey(PropertyKey.longitude),
            latitude: aDecoder.decodeDoubleForKey(PropertyKey.latitude)
        )
    }
}
extension Home:MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    // Title and subtitle for use by selection UI.
    var title: String? {
        return notes
    }
    var subtitle: String? {
        return address
    }
}