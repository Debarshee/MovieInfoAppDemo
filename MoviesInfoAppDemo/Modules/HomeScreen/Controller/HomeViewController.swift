//
//  MainViewController.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var homeTableView: UITableView! {
        didSet {
            self.homeTableView.dataSource = self
            homeTableView.tableFooterView = UIView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: Two tableview cell, one for single collection view and the other for double collection view
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Configure each table view cells that will contain the type of collection view setup
        switch indexPath.row {
        case 0:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: DoubleTypeCollectionTableViewCell.cellIdentifier,
                                                               for: indexPath) as? DoubleTypeCollectionTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            // MARK: Pass the paren view controller for navigation
            cell.parent = self
            return cell
            
        case 1:
            guard let cell = homeTableView.dequeueReusableCell(withIdentifier: SingleTypeCollectionTableViewCell.cellIdentifier,
                                                               for: indexPath) as? SingleTypeCollectionTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            // MARK: Pass the paren view controller for navigation
            // cell.parent = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: SingleTypeCollectionTableViewCellDelegate {
    func getParentViewController() -> UIViewController {
        self
    }
}
