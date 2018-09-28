//
//  MapPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 28.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

protocol MapView : NSObjectProtocol{
    func setTitle(title : String)
    func setLatitudeLongitude(latitude : Double, longitude : Double)
    func setRadius(radius : Int)
    func centerMap()
}

class MapPresenter {
    
    //MARK: - Properties
    
    var friend : FriendModel
    weak var mapView : MapView?
    
    //MARK: Lifecycle Methods
    
    init(view : MapView, friend : FriendModel){
        self.mapView = view
        self.friend = friend
    }
    
    func viewDidLoad(){
        mapView?.setTitle(title: "Address")
        
        //TODO: Fix hardcoded lat lon
        mapView?.setLatitudeLongitude(latitude: 48.856613, longitude: 2.352222)
        mapView?.setRadius(radius: 100)
        mapView?.centerMap()
    }
}
