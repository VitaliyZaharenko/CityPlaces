//
//  PointManager.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import Foundation

class PointManager {
    
    static let shared = PointManager()
    
    func all() -> [Point] {
        return [Point(lon: 30.984167, lat: 52.445278)]
    }
    
}
