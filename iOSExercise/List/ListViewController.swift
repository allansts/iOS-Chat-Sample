//
//  ViewController.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let chatSegue = "openChat"
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel: ListViewModel!
    fileprivate var selectedIndexPath = IndexPath(row: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListViewModel(table: tableView)
        viewModel.getUsers()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == chatSegue {
            let chatVC = segue.destination as! ChatViewController
            chatVC.viewModel.user = viewModel.users[selectedIndexPath.row]
        }
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId) as! UserTableViewCell
        cell.configure(user: viewModel.users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: chatSegue, sender: nil)
    }
    
}

