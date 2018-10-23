//
//  MapViewController.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var mapView: MKMapView!
    

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let point = PointManager.shared.all().first!
        focusMap(on: point, withDistance: 100000)
        
    }
    
    private func focusMap(on point: Point, withDistance: Double) {
        let focusLocation = CLLocation(latitude: point.lat, longitude: point.lon)
        let locationRegion = MKCoordinateRegionMakeWithDistance(focusLocation.coordinate, withDistance, withDistance)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    
//    private func addArtwork(on point: Point, title: String, locationName: String, discipline: String){
//        let artwork = Artwo
//    }
}

