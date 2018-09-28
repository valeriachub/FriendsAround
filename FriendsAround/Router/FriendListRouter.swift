//
//  FriendListRouter.swift
//  FriendsAround
//
//  Created by Valeria on 28.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendListRouter : ViewRouter {
    func presentDetails(for friend : FriendModel)
}

class FriendListRouterImpl : FriendListRouter {
    
    //MARK: - Properties
    
    weak var friendListViewController : FriendListViewController?
    var friend : FriendModel!
    
    //MARK: - Initializing
    
    init(friendListViewController : FriendListViewController){
        self.friendListViewController = friendListViewController
    }
    
    //MARK: - FriendListRouter Implementation
    
    func presentDetails(for friend: FriendModel) {
        self.friend = friend
        friendListViewController?.performSegue(withIdentifier: Segue.FriendSegue.rawValue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendViewController = segue.destination as? FriendDetailsViewController {
            friendViewController.configurator = FriendDetailsConfiguratorImpl(friend: friend)
        }
    }
}
