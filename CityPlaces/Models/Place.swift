//
//  Point.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject {
    
    var lon: Double = 0.0
    var lat: Double = 0.0
    
    var name: String?
    var locationName: String?
    
    init(lon: Double, lat: Double, name: String? = nil, locationName: String? = nil) {
        super.init()
        
        self.lon = lon
        self.lat = lat
        self.name = name
        self.locationName = locationName
    }
}

// MARK: - MKAnnotation

extension Place: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
        }
        
        set {
            self.lon = newValue.longitude
            self.lat = newValue.latitude
        }
    }
    
    var title: String? {
        
        get {
            return self.name
        }
        
        set {
            self.name = newValue
        }
    }
    
    var subtitle: String? {
        
        get {
            return self.locationName
        }
        
        set {
            self.locationName = newValue
        }
    }
    
}

