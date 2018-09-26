//
//  ViewController.swift
//  FriendsAround
//
//  Created by Valeria on 17.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import Alamofire

class FriendListViewController: UIViewController {
    
    //MARK: - Properties
    
    var friends : [Friend] = [Friend]()
    let presenter = FriendListPresenter()
    
    //MARK: - Outlets
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupProgressIndicator()
        
        presenter.attachView(self)
        presenter.getFriends()
    }
    
    //MARK: - Setup Methods
    
    func setupTableView(){
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        friendsTableView.rowHeight = 60.0
        friendsTableView.tableFooterView = UITableView()
        
        friendsTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "\(FriendTableViewCell.self)")
    }
    
    func setupProgressIndicator(){
        progressIndicator.stopAnimating()
        progressIndicator.hidesWhenStopped = true
    }
    
}

//MARK: - Extension UITableViewDataSource

extension FriendListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return FriendTableRow().getFriendListCell(with: friends[indexPath.row], tableView, cellForRowAt: indexPath)
    }
}

//MARK: - Extension UITableViewDelegate

extension FriendListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.FriendSegue.rawValue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let friend = friends[(friendsTableView.indexPathForSelectedRow?.row)!]
        presenter.prepareFriend(friend: friend, segue: segue)
    }
}

//MARK: - Extension FriendListView

extension FriendListViewController : FriendListView {
    func startLoading() {
        progressIndicator.startAnimating()
    }
    
    func finishLoading() {
        progressIndicator.stopAnimating()
    }
    
    func setFriends(_ friends: [Friend]) {
        self.friends = friends
        friendsTableView.reloadData()
    }
}








