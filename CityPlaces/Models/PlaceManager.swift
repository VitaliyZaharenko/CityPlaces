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
    
}
