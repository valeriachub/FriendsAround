//
//  FriendPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 27.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendPresenter {
    
    func prepareMap(for friend : Friend, segue : UIStoryboardSegue){
        switch segue.identifier {
        case Segue.MapSegue.rawValue:
            if let destination = segue.destination as? MapViewController{
                destination.latitude = friend.latitude
                destination.longitude = friend.longitude
            }
        default:
            print("Wrong segue")
        }
    }
}
