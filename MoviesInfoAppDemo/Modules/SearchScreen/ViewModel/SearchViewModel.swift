//
//  SearchViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    private var dataSource: [SearchTableCellViewModel] {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    private var showInfoData: [MovieAndTVResults]?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        self.dataSource = []
    }
    
    func fetchData(type: String) {
        let url = "\(ApiDetails.baseUrl)\(type)/popular?api_key=0736335c71dad875790ff173cf326a73&language=en-US&page=1"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data.results else { return }
                self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                self.showInfoData = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSearchedData(type: String, searchText: String) {
        let url = "\(ApiDetails.baseUrl)search/\(type)?api_key=0736335c71dad875790ff173cf326a73&language=en-US&query=\(searchText)&page=1"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let showData):
                guard let data = showData.results else { return }
                self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                self.showInfoData = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        self.dataSource.count
    }
    
    func searchListShow(at index: Int) -> SearchTableCellViewModel {
        self.dataSource[index]
    }
    
    func selectedList(at index: Int) -> MovieAndTVResults {
        guard let showInfo = self.showInfoData?[index] else {
            fatalError("Info Error")
        }
        return showInfo
    }
}
