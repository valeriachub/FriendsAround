//
//  ViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    
    var friends : [User] = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let END_POINT = "https://randomuser.me/api/"
    
    //MARK: - Outlets
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        friends = getLocalFriends()
        if friends.count == 0 {
            loadFriends()
        }
    }
    
    //MARK: - Setup Methods
    
    func setupTableView(){
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        friendsTableView.rowHeight = 60.0
        friendsTableView.tableFooterView = UITableView()
        
        friendsTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "friendCell")
    }
    
    //MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendTableViewCell
            else {fatalError("dequeueReusableCell Error")}
        
        let friend = friends[indexPath.row]
        
        cell.nameView.text = friend.name
        
        Alamofire.request(friend.picture!).validate().responseImage {
            (response) in
            switch response.result {
            case .success(let value): cell.pictureView.image = value.af_imageRoundedIntoCircle()
            case .failure(let error) :
                cell.pictureView.image = UIImage(named: "placeholder")?.af_imageRoundedIntoCircle()
                print(error)
            }
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "friendSegue", sender: self)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "friendSegue":
            if let destination = segue.destination as? FriendViewController{
                let friend = friends[(friendsTableView.indexPathForSelectedRow?.row)!]
                destination.friend = friend
            }
        default:
            print("Wrong segue")
        }
    }
    
    //MARK: - Data Methods
    
    func getLocalFriends() -> [User] {
        let userRequest : NSFetchRequest<User> = User.fetchRequest()
        var users = [User]()
        do{
            try users = context.fetch(userRequest)
        }catch{
            print("Error fetching Friends")
        }
        return users
    }
    
    //TODO: - Refactor this huge method. Create another module like NetworkModule to perform all actions with data from the network
    func loadFriends(){
        //API works without error only if get only 4 users 🤷‍♀️ 
        for _ in 0...3 {
            request(END_POINT).validate().responseJSON {
                [unowned self, unowned context]
                (response) in
                switch(response.result) {
                case .success(let value):
                    let friend = User(context:self.context)
                    
                    guard let user = value as? [String : Any] else {return}
                    guard let results = user["results"] as? Array<[String : Any]> else {return}
                    let result = results[0]
                    
                    if let name = result["name"] as? [String:String] {
                        let username = name["first"]! + " " + name["last"]!
                        print(username)
                        friend.setValue(username, forKey: "name")
                    }
                    if let location = result["location"] as? [String:Any] {
                        if let coordinates = location["coordinates"] as? [String:String]{
                            let latitude = (coordinates["latitude"]! as NSString).doubleValue
                            let longitude = (coordinates["longitude"]! as NSString).doubleValue
                            print("\(latitude) \(longitude)")
                            friend.setValue(latitude, forKey: "latitude")
                            friend.setValue(longitude, forKey: "longitude")
                        }
                    }
                    if let picture = result["picture"] as? [String:String] {
                        let medium = picture["large"]!
                        print(medium)
                        friend.setValue(medium, forKey: "picture")
                    }
                    if let dob = result["dob"] as? [String:Any]{
                        if let age = dob["age"] as? Int16{
                            print("\(age)")
                            friend.setValue(age, forKey: "age")
                        }
                    }
                    do{
                        try context.save()
                        self.friends.append(friend)
                    }catch {
                        print("Error saving")
                    }
                    self.friendsTableView.reloadData()
                case .failure(let error): print(error)
                }
            }
        }
    }
}

