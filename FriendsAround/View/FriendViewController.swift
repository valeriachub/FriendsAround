//
//  FriendViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {
    
    //MARK: - Properties
    
    var friend : Friend?
    let presenter = FriendPresenter()
    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var ageView: UILabel!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let friend = friend else {fatalError()}
        title = friend.name
        setupFriend(friend)
    }
    
    //MARK: - Setup Methods
    
    func setupFriend(_ friend : Friend){
        nameView.text = friend.name
        ageView.text = "\(friend.age!)"
        
        pictureView.image = UIImage(named: "placeholder")?.af_imageRoundedIntoCircle()
        
        ImageLoader().getImageData(by: friend.picture!, {
            [unowned self]
            (imageData) in
            self.pictureView.image = UIImage(data: imageData)?.af_imageRoundedIntoCircle()
        })
    }
    
    //MARK: - Actions
    
    @IBAction func showAddressOnMap(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.MapSegue.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepareMap(for: friend!, segue: segue)
    }
}
