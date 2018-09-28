//
//  ImageLoader.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import Foundation

class ImageLoader {
    
    func getImageData(by url : String, _ callback : @escaping (Data)->Void){
        let dispatchQueue = DispatchQueue.global(qos: .background)
        dispatchQueue.async {
            if let url = URL(string: url){
                do{
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        callback(data)
                    }
                }catch{
                    print("Error loading image")
                }
            }
        }
    }
}
