//
//  FriendListPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendListView : NSObjectProtocol {
    func setupTable()
    func setupProgressIndicator()
    func startLoading()
    func finishLoading()
    func reloadTable()
}

class FriendListPresenter {
    
    //MARK: - Properties
    
    var friends : [FriendModel] = [FriendModel]()
    weak var friendListView : FriendListView?
    let router : FriendListRouter
    let dataService = FriendDataService.shared
    
    //MARK: - Lifecycle Methods
    
    init(view : FriendListView, router : FriendListRouter){
        self.friendListView = view
        self.router = router
    }
    
    func viewDidLoad(){
        getFriends()
        friendListView?.setupTable()
        friendListView?.setupProgressIndicator()
    }
    
    //MARK: - Data Methods
    
    func getFriends(){
        friendListView?.startLoading()
        dataService.getFriends{
            [unowned self]
            friends in
            self.friendListView?.finishLoading()
            self.friends = friends
            self.friendListView?.reloadTable()
        }
    }
    
    func getNumberOfRowsInSection() -> Int{
        return friends.count
    }
    
    func getCellForRow(_ tableView : UITableView, at indexPath : IndexPath) -> UITableViewCell{
         return FriendTableRow().getFriendListCell(with: friends[indexPath.row], tableView, cellForRowAt: indexPath)
    }
    
    //MARK: - Navigation Methods
    
    func didSelect(row : Int){
        let friend = friends[row]
        router.presentDetails(for: friend)
    }
}
