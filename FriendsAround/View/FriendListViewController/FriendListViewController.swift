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
    
    var configurator = FriendListConfiguratorImpl()
    var presenter : FriendListPresenter!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(friendListViewController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

//MARK: - Extension UITableViewDataSource

extension FriendListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.getCellForRow(tableView, at: indexPath)
    }
}

//MARK: - Extension UITableViewDelegate

extension FriendListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row : indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Extension FriendListView

extension FriendListViewController : FriendListView {
    
    func setupTable(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60.0
        tableView.tableFooterView = UITableView()
        
        tableView.register(UINib(nibName: "\(FriendTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(FriendTableViewCell.self)")
    }
    
    func setupProgressIndicator(){
        progressIndicator.stopAnimating()
        progressIndicator.hidesWhenStopped = true
    }
    
    func startLoading() {
        progressIndicator.startAnimating()
    }
    
    func finishLoading() {
        progressIndicator.stopAnimating()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}








