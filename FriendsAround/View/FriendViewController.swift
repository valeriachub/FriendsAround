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
    
    var data : Friend?
    var presenter : FriendPresenter?
    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var ageView: UILabel!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = data else {fatalError()}
        presenter = FriendPresenter(data)
        presenter?.attachView(self)
    }
    
    //MARK: - Actions
    
    @IBAction func showAddressOnMap(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.MapSegue.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter?.prepareSegue(segue: segue)
    }
}

//MARK: - Extension FriendView

extension FriendViewController : FriendView {
    func setData(_ data : Friend) {
        title = data.name
        nameView.text = data.name
        ageView.text = "\(data.age!)"
        
         ImageLoader().getImageData(by: data.picture!, {
            [unowned self]
            (imageData) in
            self.pictureView.image = UIImage(data: imageData)
        })
    }
    
    
}
