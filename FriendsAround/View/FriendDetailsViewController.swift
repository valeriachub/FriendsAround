//
//  FriendDetailsViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FriendDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var configurator : FriendDetailsConfigurator!
    var presenter : FriendDetailsPresenter!
    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var ageView: UILabel!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(friendDetailsController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    //MARK: - Actions
    
    @IBAction func showAddressOnMap(_ sender: UIButton) {
        presenter.showAddressOnMap()
    }
}

//MARK: - Extension FriendView

extension FriendDetailsViewController : FriendView {
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setImage(image: UIImage) {
        pictureView.image = image
    }
    
    func setName(name: String) {
        nameView.text = name
    }
    
    func setAge(age: Int) {
        ageView.text = String(age)
    }
}
