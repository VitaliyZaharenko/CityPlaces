//
//  MapViewController.swift
//  CityPlaces
//
//  Created by zaharenkov on 23/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import UIKit
import MapKit


fileprivate struct Const {
    
    static let userLocationRegionExpandRadius: CLLocationDistance = 10000
}


fileprivate enum MapType: Int {
    
    case standart
    case satellite
    case hybrid
}

class MapViewController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var userLocationToolbarItem: UIBarButtonItem!
    
    
    //MARK: - Properties
    
    private var mapType: MapType = .standart {
        didSet {
            setMapType()
        }
    }
    
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureLocationManager()
        
    }
    
    //MARK: - Actions
    
    @IBAction func setMapStandartType(_ sender: UIBarButtonItem) {
        mapType = .standart
    }
    
    @IBAction func setMapSatelliteType(_ sender: UIBarButtonItem) {
        mapType = .satellite
    }
    
    @IBAction func setMapHybridType(_ sender: UIBarButtonItem) {
        mapType = .hybrid
    }
    
    @IBAction func showUserLocation(_ sender: UIBarButtonItem) {
        
        if let userLocation = userLocation {
            moveTo(coordinate: userLocation)
        }
    }
    
}


//MARK: - Private Help Methods

extension MapViewController {
    
    
    private func configureMapView(){
        
        mapView.delegate = self
        
        let point = PlaceManager.shared.all().first!
        focusMap(on: point, withDistance: 100000)
        addAnnotation(on: point)
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = CLLocationManager.authorizationStatus()
        updateAutorization(status: status)
        
        
        
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
    
    
    private func focusMap(on point: Place, withDistance: Double) {
        let focusLocation = CLLocation(latitude: point.lat, longitude: point.lon)
        let locationRegion = MKCoordinateRegionMakeWithDistance(focusLocation.coordinate, withDistance, withDistance)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    
    private func addAnnotation(on point: Place){
        mapView.addAnnotation(point)
    }
    
    private func enableUserLocationButton(enable: Bool){
        userLocationToolbarItem.isEnabled = enable
    }
    
    private func moveTo(coordinate: CLLocationCoordinate2D, regionRadius: CLLocationDistance = Const.userLocationRegionExpandRadius){
        
        let locationRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius, regionRadius)
        mapView.setRegion(locationRegion, animated: true)
    }
    
    private func updateAutorization(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            enableUserLocationButton(enable: true)
            mapView.showsUserLocation = true
        case .denied, .restricted:
            enableUserLocationButton(enable: false)
            mapView.showsUserLocation = false
        }
    }
}


//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let alertController = UIAlertController(title: "Info", message: nil, preferredStyle: .alert)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Consts.placeAnnotationViewReuseId)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Consts.placeAnnotationViewReuseId)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        let image = UIImage(named: "forest")
        annotationView!.image = image
        return annotationView
    }
}


//MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateAutorization(status: status)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.userLocation = userLocation.coordinate
    }
    
    
}
