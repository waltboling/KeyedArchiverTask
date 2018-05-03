//
//  Teams.swift
//  KeyedArchiverTask
//
//  Created by Jon Boling on 4/30/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class Teams: NSObject, NSCoding {
    
    
    let city: String
    let teamName: String
    let colorOne: UIColor
    let colorTwo: UIColor
    let mascot: UIImage?
    
    init(city: String, teamName:String, colorOne: UIColor, colorTwo: UIColor, mascot: UIImage) {
        self.city = city
        self.teamName = teamName
        self.colorOne = colorOne
        self.colorTwo = colorTwo
        self.mascot = mascot
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let city = aDecoder.decodeObject(forKey: "city") as? String,
            let teamName = aDecoder.decodeObject(forKey: "teamName") as? String,
            let colorOne = aDecoder.decodeObject(forKey: "colorOne") as? UIColor,
            let colorTwo = aDecoder.decodeObject(forKey: "colorTwo") as? UIColor,
            let mascot = aDecoder.decodeObject(forKey: "mascot") as? UIImage
            else {return nil}
        self.init(city: city, teamName: teamName, colorOne: colorOne, colorTwo: colorTwo, mascot: mascot)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.teamName, forKey: "teamName")
        aCoder.encode(self.colorOne, forKey: "colorOne")
        aCoder.encode(self.colorTwo, forKey: "colorTwo")
        aCoder.encode(self.mascot, forKey: "mascot")
    }
    
    var title: String {
        return "\(city) \(teamName)"
    }
}
