//
//  FriendListPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendListView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setFriends(_ friends : [Friend])
}

class FriendListPresenter {
    
    //MARK: - Properties
    
    weak var friendListView : FriendListView?
    let dataService = FriendDataService.shared
    
    //MARK: - Lifecycle Methods
    
    func attachView(_ view : FriendListView){
        self.friendListView = view
    }
    
    func detachView(){
        self.friendListView = nil
    }
    
    //MARK: - Data Methods
    
    func getFriends(){
        friendListView?.startLoading()
        dataService.getFriends{
            [unowned self]
            friends in
            self.friendListView?.finishLoading()
            self.friendListView?.setFriends(friends)
        }
    }
    
    //MARK: - Navigation Methods
    
    func prepareFriend(friend : Friend, segue : UIStoryboardSegue){
        switch segue.identifier {
        case Segue.FriendSegue.rawValue:
            if let destination = segue.destination as? FriendViewController {
                destination.friend = friend
            }
        default:
            print("Wrong segue")
        }
    }
}
