//
//  LocalStorage.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

class LocalSource {
    
    //MARK: - Properties
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = delegate.persistentContainer.viewContext
    
    //MARK: - Get Methods
    
    func getFriends() -> [Friend] {
        let userRequest : NSFetchRequest<User> = User.fetchRequest()
        var friends = [Friend]()
        do{
            let users = try managedContext.fetch(userRequest)
            for user in users {
                let friend = Friend(from:user)
                friends.append(friend)
            }
        }catch{
            print("Error fetching Friends")
        }
        return friends
    }
    
    //MARK - Save Methods
    
    func saveFriends(_ friends : [Friend]) {
        for friend in friends {
            saveFriend(friend)
        }
    }
    
    private func saveFriend(_ friend : Friend) {
        let user = User(context: managedContext)
        user.name = friend.name
        user.picture = friend.picture
        if
            let latitude = friend.latitude,
            let longitude = friend.longitude
        {
            user.latitude = latitude
            user.longitude = longitude
        }
        if let age = friend.age{
            if let age16 = Int16(exactly: NSNumber(value: age)){
                user.age = age16
            }
        }
        
        do{
            try managedContext.save()
        }catch{
            print("Error saving friend")
        }
    }
}
