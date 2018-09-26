//
//  DataService.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

class FriendDataService {
    
    //MARK: - Singleton initializing
    
    static let shared = FriendDataService()
    private init(){}
    
    //MARK: - Properties
    
    private let localSource = LocalSource()
    private let remoteSource = RemoteSource()
    private let appSource = AppSource()
    
    
    //MARK: - Get Data Methods
    
    func getFriends(_ callback : @escaping ([Friend]) -> Void){
        
        if !appSource.isNotFirstLaunch() {
            remoteSource.loadFriends {
                [unowned self]
                (friends) in
                self.localSource.saveFriends(friends)
                callback(friends)
            }
        }else {
            callback(localSource.getFriends())
        }
    }
}
