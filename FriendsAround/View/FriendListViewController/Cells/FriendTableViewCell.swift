//
//  FriendTableViewCell.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class FriendTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    
    //MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureView.af_cancelImageRequest()
    }
}
