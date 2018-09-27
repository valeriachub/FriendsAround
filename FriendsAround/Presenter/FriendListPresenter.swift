//
//  FriendListPresenter.swift
//  FriendsAround
//
//  Created by Valeria on 26.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol FriendListView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func reloadTable()
}

class FriendListPresenter {
    
    //MARK: - Properties
    
    var friends : [Friend] = [Friend]()
    weak var friendListView : FriendListView?
    let dataService = FriendDataService.shared
    
    //MARK: - Lifecycle Methods
    
    func attachView(_ view : FriendListView){
        self.friendListView = view
        getFriends()
    }
    
    func detachView(){
        self.friendListView = nil
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
    
    func prepareSegue(selectedRow : Int, segue : UIStoryboardSegue){
        let friend = friends[selectedRow]
        switch segue.identifier {
        case Segue.FriendSegue.rawValue:
            if let destination = segue.destination as? FriendViewController {
                destination.data = friend
            }
        default:
            print("Wrong segue")
        }
    }
}
