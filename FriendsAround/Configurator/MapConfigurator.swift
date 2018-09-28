//
//  MapCoordinator.swift
//  FriendsAround
//
//  Created by Valeria on 28.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

protocol MapConfigurator {
    func configure(mapViewController : MapViewController)
}

class MapConfiguratorImpl : MapConfigurator {
    
    //MARK: - Properties
    
    var friend : FriendModel
    
    //MARK: - Initializing
    
    init(friend : FriendModel){
        self.friend = friend
    }
    
    //MARK: - MapConfigurator Inplementation
    
    func configure(mapViewController: MapViewController) {
        let presenter = MapPresenter(view: mapViewController, friend: friend)
        
        mapViewController.presenter = presenter
    }
}
