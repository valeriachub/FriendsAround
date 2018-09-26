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
    
    var latitude : Double?
    var longitude : Double?
    
    var initialLocation : CLLocation?
    let radius : CLLocationDistance = 1000
    
    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Address"
        
        initialLocation = CLLocation(latitude: 48.856613, longitude: 2.352222)
        centerMapOnLocation(location: initialLocation!, radius: radius)
    }
    
    //MARK: - Map Methods
    
    func centerMapOnLocation(location : CLLocation, radius : CLLocationDistance){
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
        mapView.setRegion(region, animated: true)
    }
}
