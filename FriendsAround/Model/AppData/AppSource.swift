//
//  UserDefaultsSource.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

class AppSource {
    
    private let NOT_FIRST_LAUNCH = "not_first_launch"
    
    func isNotFirstLaunch() -> Bool {
        let isNotFirstLaunch = UserDefaults.standard.bool(forKey: NOT_FIRST_LAUNCH)
        print("isNotFirstLaunch = \(isNotFirstLaunch)")
        if !isNotFirstLaunch{
            UserDefaults.standard.set(true, forKey: NOT_FIRST_LAUNCH)
        }
        return isNotFirstLaunch
    }
}
