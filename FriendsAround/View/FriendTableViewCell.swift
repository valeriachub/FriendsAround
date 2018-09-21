//
//  FriendTableViewCell.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
