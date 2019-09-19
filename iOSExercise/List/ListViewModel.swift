//
//  ListViewModel.swift
//  iOSExercise
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class ListViewModel {

    fileprivate var repository: BaseRepository
    fileprivate var tableView: UITableView
    
    var users = [User]()
    
    init(table: UITableView) {
        self.tableView = table
        repository = BaseRepository.shared
    }
    
    func getUsers() {
        users = repository.fechtUsers()
        tableView.reloadData()
    }
    
}
