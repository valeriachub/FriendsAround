//
//  FriendPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 27.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendView : NSObjectProtocol {
    func setData(_ friend: Friend)
}

class FriendPresenter {
    
    //MARK: - Properties
    
    var friend : Friend?
    weak var friendView : FriendView?
    
    //MARK: Lifecycle Methods
    
    init(_ friend : Friend){
        self.friend = friend
    }
    
    func attachView(_ view : FriendView){
        self.friendView = view
        friendView?.setData(friend!)
    }
    
    func detachView(){
        self.friendView = nil
    }
    
    //MARK: - Navigation Methods
    
    func prepareSegue(segue : UIStoryboardSegue){
        switch segue.identifier {
        case Segue.MapSegue.rawValue:
            if let destination = segue.destination as? MapViewController{
                destination.latitude = friend?.latitude
                destination.longitude = friend?.longitude
            }
        default:
            print("Wrong segue")
        }
    }
}
