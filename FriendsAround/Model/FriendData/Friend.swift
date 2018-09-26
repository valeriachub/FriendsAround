//
//  Friend.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

class Friend {
    
    var name : String?
    var picture : String?
    var age : Int?
    var latitude : Double?
    var longitude : Double?
    
    init?(from value : Any){
        guard let user = value as? [String : Any] else {return nil}
        guard let results = user["results"] as? Array<[String : Any]> else {return nil}
        let result = results[0]
 
        if
            let name = result["name"] as? [String:String],
            let location = result["location"] as? [String:Any],
            let coordinates = location["coordinates"] as? [String:String],
            let picture = result["picture"] as? [String:String],
            let dob = result["dob"] as? [String:Any]
        {
            self.name = name["first"]! + " " + name["last"]!
            self.latitude = (coordinates["latitude"]! as NSString).doubleValue
            self.longitude = (coordinates["longitude"]! as NSString).doubleValue
            self.picture = picture["large"]!
            self.age = dob["age"] as? Int
       
        }else{
            return nil
        }
    }
    
    init(from user : User){
        self.name = user.name
        self.latitude = user.latitude
        self.longitude = user.longitude
        self.picture = user.picture
        self.age = Int(user.age)
    }
}
