//
//  FriendDetailsRouter.swift
//  FriendsAround
//
//  Created by Valeria on 28.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendDetailsRouter : ViewRouter {
    func presentMap(for friend : FriendModel)
}

class FriendDetailsRouterImpl : FriendDetailsRouter {
    
    //MARK: - Properties
    
    weak var friendDetailsViewController : FriendDetailsViewController?
    var friend : FriendModel!
    
    //MARK: - Initializing
    
    init(friendDetailsViewController : FriendDetailsViewController){
        self.friendDetailsViewController = friendDetailsViewController
    }
    
    //MARK: - FriendDetailsRouter Implementation
    
    func presentMap(for friend: FriendModel) {
        self.friend = friend
        friendDetailsViewController?.performSegue(withIdentifier: Segue.MapSegue.rawValue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapViewController = segue.destination as? MapViewController {
            mapViewController.coordinator = MapConfiguratorImpl(friend: friend)
        }
    }
}
