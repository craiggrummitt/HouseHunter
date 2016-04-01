//
//  Home.swift
//  HouseHunter
//
//  Created by Craig Grummitt on 7/03/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import Foundation

class Home:NSObject, NSCoding {
    var notes:String
    var address:String
    var rating:Float
    
    init(notes:String,address:String,rating:Float) {
        self.notes = notes
        self.address = address
        self.rating = rating
    }
    //MARK: Types
    struct PropertyKey {
        static let notes = "notes"
        static let address = "address"
        static let rating = "rating"
    }
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let HomesDirectory = DocumentsDirectory.URLByAppendingPathComponent("homes")
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.notes, forKey: PropertyKey.notes)
        aCoder.encodeObject(self.address, forKey: PropertyKey.address)
        aCoder.encodeFloat(self.rating, forKey: PropertyKey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let notes = aDecoder.decodeObjectForKey(PropertyKey.notes) as? String,
        let address = aDecoder.decodeObjectForKey(PropertyKey.address) as? String
        else {return nil}
        self.init(
            notes: notes,
            address: address,
            rating: aDecoder.decodeFloatForKey(PropertyKey.rating)
        )
    }
}