//
//  FriendPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 27.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendView : NSObjectProtocol {
    func setTitle(title : String)
    func setImage(image : UIImage)
    func setName(name : String)
    func setAge(age : Int)
}

class FriendDetailsPresenter {
    
    //MARK: - Properties
    
    var friend : FriendModel
    weak var friendDetailsView : FriendView?
    var router : FriendDetailsRouter
    
    //MARK: Lifecycle Methods
    
    init(friendDetailsView : FriendView, router : FriendDetailsRouter, _ friend : FriendModel){
        self.friend = friend
        self.friendDetailsView = friendDetailsView
        self.router = router
    }
    
    func viewDidLoad(){
        friendDetailsView?.setTitle(title: friend.name!)
        friendDetailsView?.setName(name: friend.name!)
        friendDetailsView?.setAge(age: friend.age!)
        
        ImageLoader().getImageData(by: friend.picture!, {
            [unowned self]
            (imageData) in
            self.friendDetailsView?.setImage(image: UIImage(data: imageData)!)
        })
    }
    
    //MARK: - Navigation Methods
    
    func showAddressOnMap(){
        router.presentMap(for: friend)
    }
}
