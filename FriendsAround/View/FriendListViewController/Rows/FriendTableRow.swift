//
//  FriendTableRow.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendTableRow {
    
    func getFriendListCell(with friend : Friend, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> FriendTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FriendTableViewCell.self)", for: indexPath) as? FriendTableViewCell
            else {fatalError("dequeueReusableCell Error")}
        
        print("index  = \(indexPath.row)")
        
        cell.nameView.text = friend.name
        ImageLoader().getImageData(by: friend.picture!, {
            (imageData) in
            cell.pictureView?.image = UIImage(data: imageData)
        })
        
        return cell
    }
}
