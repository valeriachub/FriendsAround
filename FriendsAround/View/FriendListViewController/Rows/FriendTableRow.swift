//
//  FriendTableRow.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendTableRow {
    
    func getFriendListCell(with friend : FriendModel, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> FriendTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FriendTableViewCell.self)", for: indexPath) as? FriendTableViewCell
            else {fatalError("FriendTableRow DequeueReusableCell Error")}
      
        cell.nameView.text = friend.name
        
        //TODO: Move in another place
        
        ImageLoader().getImageData(by: friend.picture!, {
            (imageData) in
            cell.pictureView?.image = UIImage(data: imageData)
        })
        
        return cell
    }
}
