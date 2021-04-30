//
//  SearchViewController.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/12/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchSegmentedControl: UISegmentedControl! {
        didSet {
            self.listTableView.reloadData()
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
        }
    }
    @IBOutlet private weak var listTableView: UITableView! {
        didSet {
            self.listTableView.dataSource = self
            self.listTableView.delegate = self
            self.listTableView.tableFooterView = UIView()
        }
    }
    
    lazy var searchViewModel = SearchViewModel(delegate: self)
    
    var searchType = "movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.searchViewModel = SearchViewModel(delegate: self)
        searchSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        searchSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.searchBar.layer.cornerRadius = 20
        self.searchBar.clipsToBounds = true
        // searchSegmentedControl.layer.borderWidth = 1
        // searchSegmentedControl.layer.borderColor = UIColor.systemYellow.cgColor
        self.searchViewModel.fetchData(type: searchType)
    }
    
    private func searchedData(for searchText: String) {
        if !searchText.isEmpty {
            self.searchViewModel.fetchSearchedData(type: searchType, searchText: searchText)
        } else {
            self.searchViewModel.fetchData(type: searchType)
        }
    }

    @IBAction private func selectedSearchOption(_ sender: UISegmentedControl) {
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            searchType = "movie"
            guard let searchedText = searchBar.text else { return }
            searchedData(for: searchedText)
            
        case 1:
            searchType = "tv"
            guard let searchedText = searchBar.text else { return }
            searchedData(for: searchedText)
            
        default:
            break
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchViewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let data = self.searchViewModel.searchListShow(at: indexPath.row)
        cell.configure(from: data)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.info = self.searchViewModel.selectedList(at: indexPath.row)
        detailViewController.type = searchType
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchSegmentedControl.isHidden = false
        self.searchedData(for: searchText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadData() {
        self.listTableView.reloadData()
    }
}
