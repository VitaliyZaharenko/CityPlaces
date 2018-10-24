//
//  MapViewController.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import UIKit
import MapKit


fileprivate enum MapType: Int {
    
    case standart
    case satellite
    case hybrid
}

class MapViewController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tabBar: UITabBar!
    
    //MARK: - Properties
    
    private var mapType: MapType = .standart {
        didSet {
            setMapType()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureMapView()
    }
    
    
}

//MARK: Private Help Methods

extension MapViewController {
    
    private func configureTabBar(){
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items!.first
    }
    
    private func configureMapView(){
        
        mapView.delegate = self
        
        let point = PointManager.shared.all().first!
        focusMap(on: point, withDistance: 100000)
        addAnnotation(on: point, title: "GOMEL MARKER", subtitle: nil)
    }
    
    private func setMapType(){
        print(mapType)
        switch mapType {
        case .standart:
            mapView.mapType = .standard
        case .satellite:
            mapView.mapType = .satellite
        case .hybrid:
            mapView.mapType = .hybrid
        }
    }
    
    
    private func focusMap(on point: Point, withDistance: Double) {
        let focusLocation = CLLocation(latitude: point.lat, longitude: point.lon)
        let locationRegion = MKCoordinateRegionMakeWithDistance(focusLocation.coordinate, withDistance, withDistance)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    
    private func addAnnotation(on point: Point, title: String?, subtitle: String?){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocation(latitude: point.lat, longitude: point.lon).coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
}


//MARK: - UITabBarDelegate

extension MapViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case Consts.StandartBarItem.tag:
            mapType = .standart
        case Consts.SatelliteBarItem.tag:
            mapType = .satellite
        case Consts.HybridBarItem.tag:
            mapType = .hybrid
        default:
            fatalError("Unknown TabBarItem tag = \(item.tag)")
        }
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
    }
}

