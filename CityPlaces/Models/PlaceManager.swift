//
//  PointManager.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import Foundation

class PlaceManager {
    
    static let shared = PlaceManager()
    
    func all() -> [Place] {
        return [Place(lon: 30.984167,
                      lat: 52.445278,
                      name: "GOMEL CITY",
                      locationName: "GOMEL! GOMEL! GOMEL!")]
    }
    
    
    
    static func ParsePlaces() throws -> [Place] {
        guard let plistUrl = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            fatalError("Plist not found")
        }
        guard let publicArtFileName = NSDictionary(contentsOf: plistUrl)?.value(forKey: Consts.publicArtFileNamePlistKey) as? String else {
            fatalError("Error when trying to get filename from plist file")
        }
        let url = Bundle.main.url(forResource: publicArtFileName, withExtension: "json", subdirectory: nil)
        let data = try? Data(contentsOf: url!)
        let parser = PlaceParser(from: data!)
        let places = try parser.parse()
        return places
    }
    
}
