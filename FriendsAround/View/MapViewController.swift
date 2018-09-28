//
//  MapViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter : MapPresenter!
    var coordinator : MapConfiguratorImpl!
    
    var initialLocation : CLLocation?
    var radius : CLLocationDistance?
    
    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator.configure(mapViewController: self)
        presenter.viewDidLoad()
    }
}

//MARK: - Extension MapView

extension MapViewController : MapView {
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setLatitudeLongitude(latitude: Double, longitude: Double) {
        initialLocation = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func setRadius(radius: Int) {
        self.radius = CLLocationDistance(radius)
    }
    
    func centerMap() {
        centerMapOnLocation(location: initialLocation!, radius: radius!)
    }
}

//MARK: - Extension Map

extension MapViewController {
    
    func centerMapOnLocation(location : CLLocation, radius : CLLocationDistance){
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
        mapView.setRegion(region, animated: true)
    }
}
