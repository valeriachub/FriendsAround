//
//  FriendViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FriendViewController: UIViewController {
    
    //MARK: - Properties
    
    var friend : User?
    
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
    
    func setupFriend(_ friend : User){
        nameView.text = friend.name
        ageView.text = "\(friend.age)"
        
        Alamofire.request(friend.picture!).validate().responseImage {
            [unowned self]
            (response) in
            switch response.result {
            case .success(let value): self.pictureView.image = value.af_imageRoundedIntoCircle()
            case .failure(let error) :
                self.pictureView.image = UIImage(named: "placeholder")?.af_imageRoundedIntoCircle()
                print(error)
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func showAddressOnMap(_ sender: UIButton) {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "mapSegue":
            if let destination = segue.destination as? MapViewController{
                destination.latitude = friend!.latitude
                destination.longitude = friend!.longitude
            }
        default:
            print("Wrong segue")
        }
    }
}
