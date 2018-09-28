//
//  FriendDetailsConfigurator.swift
//  FriendsAround
//
//  Created by Valeria on 28.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

protocol FriendDetailsConfigurator {
    func configure(friendDetailsController : FriendDetailsViewController)
}

class FriendDetailsConfiguratorImpl : FriendDetailsConfigurator {
    
    //MARK: - Properties
    
    let friend : FriendModel
    
    //MARK: - Initializing
    
    init(friend : FriendModel){
        self.friend = friend
    }
    
    //MARK: - FriendDetailsConfigurator Implementation
    
    func configure(friendDetailsController: FriendDetailsViewController) {
        let router = FriendDetailsRouterImpl(friendDetailsViewController: friendDetailsController)
        let presenter = FriendDetailsPresenter(friendDetailsView: friendDetailsController, router: router, friend)
        
        friendDetailsController.presenter = presenter
    }
}
