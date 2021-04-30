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
    let router = Router<MovieApi>()
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        self.dataSource = []
    }
    
    func fetchData(type: String) {
        switch type {
        case "movie":
            self.router.request(.newMovies(page: 1)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        case "tv":
            self.router.request(.newTVShows(page: 1)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            break
        }
    }
    
    func fetchSearchedData(type: String, searchText: String) {
        switch type {
        case "movie":
            self.router.request(.searchMovie(page: 1, query: searchText)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        case "tv":
            self.router.request(.searchTV(page: 1, query: searchText)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.dataSource = data.compactMap { SearchTableCellViewModel(searchListData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            break
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
