//
//  RemoteStorage.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

class RemoteSource{
    
    let END_POINT = "https://randomuser.me/api/"
    
    func loadFriends(_ callback : @escaping ([Friend]) -> Void){
        var friends = [Friend]()
        
        let dispatchGroup = DispatchGroup()
        
        for _ in 1...20 {
            DispatchQueue.global().async(group: dispatchGroup) {
                let url = URL(string: self.END_POINT)
                do{
                    let data = try Data(contentsOf: url!)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let friend = Friend(from: json){
                        friends.append(friend)
                    }
                }catch{
                    print("Error")
                }
            }
        }
        
        dispatchGroup.notify(queue : DispatchQueue.main){
            callback(friends)
        }
    }
}
