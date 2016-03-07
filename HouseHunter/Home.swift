//
//  HomeModel.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 29/02/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public class Home: NSObject, NSCoding {
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
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let HomesDirectory = DocumentsDirectory.URLByAppendingPathComponent("homes")
    
    // MARK: Types
    struct PropertyKey {
        static let notes = "notes"
        static let address = "address"
        static let rating = "rating"
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    
    // MARK: NSCoding
    convenience required public init?(coder decoder: NSCoder) {
        guard let notes = decoder.decodeObjectForKey(PropertyKey.notes) as? String,
            let address = decoder.decodeObjectForKey(PropertyKey.address) as? String
            else { return nil }
        
        self.init(
            notes: notes,
            address: address,
            rating: decoder.decodeFloatForKey(PropertyKey.rating),
            longitude: decoder.decodeDoubleForKey(PropertyKey.longitude),
            latitude: decoder.decodeDoubleForKey(PropertyKey.latitude)
        )
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.notes, forKey: PropertyKey.notes)
        coder.encodeObject(self.address, forKey: PropertyKey.address)
        coder.encodeFloat(self.rating, forKey: PropertyKey.rating)
        coder.encodeDouble(self.longitude, forKey: PropertyKey.longitude)
        coder.encodeDouble(self.latitude, forKey: PropertyKey.latitude)
    }
}
extension Home:MKAnnotation {
    //MARK: MKAnnotation
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    // Title and subtitle for use by selection UI.
    public var title: String? {
        return self.address
    }
    public var subtitle: String? {
        return self.notes
    }
}
