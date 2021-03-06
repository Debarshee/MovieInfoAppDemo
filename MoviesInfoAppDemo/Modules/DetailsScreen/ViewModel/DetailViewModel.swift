//
//  DetailViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/23/21.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func castCollectionReloadData()
    func similarCollectionReloadData()
}

class DetailViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    private var showInfoData: [MovieAndTVResults]?
    private var castCollectionDataSource: [CastCollectionCellViewModel] {
        didSet {
            self.delegate?.castCollectionReloadData()
        }
    }
    private var similarCollectionDataSource: [SimilarCollectionCellViewModel] {
        didSet {
            self.delegate?.similarCollectionReloadData()
        }
    }
    
    let router = Router<MovieApi>()
    
    // MARK: - Initializer
    init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
        self.castCollectionDataSource = []
        self.similarCollectionDataSource = []
    }
    
    // MARK: - Public functions
    func numberOfRowsInCastCollection(section: Int) -> Int {
        self.castCollectionDataSource.count
    }
    
    func numberOfRowsInSimilarCollection(section: Int) -> Int {
        self.similarCollectionDataSource.count
    }
    
    func castCollectionShow(at index: Int) -> CastCollectionCellViewModel {
        self.castCollectionDataSource[index]
    }
    
    func similarCollectionShow(at index: Int) -> SimilarCollectionCellViewModel {
        self.similarCollectionDataSource[index]
    }
    
    func selectedList(at index: Int) -> MovieAndTVResults {
        guard let showInfo = self.showInfoData?[index] else {
            fatalError("Info Error")
        }
        return showInfo
    }
    
    func castCollectionData(dataType: String, movieId: Int) {
        switch dataType {
        case "movie":
            self.router.request(.movieCasts(id: movieId)) { (result: Result<People, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.cast else { return }
                    self.castCollectionDataSource = data.compactMap { CastCollectionCellViewModel(castCollectionData: $0) }
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        case "tv":
            self.router.request(.tvCasts(id: movieId)) { (result: Result<People, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.cast else { return }
                    self.castCollectionDataSource = data.compactMap { CastCollectionCellViewModel(castCollectionData: $0) }
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            break
        }
    }
    
    func similarCollectionData(dataType: String, movieId: Int) {
        switch dataType {
        case "movie":
            self.router.request(.similarMovie(id: movieId)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.similarCollectionDataSource = data.compactMap { SimilarCollectionCellViewModel(similarCollectionData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        case "tv":
            self.router.request(.similarTVShow(id: movieId)) { (result: Result<MoviesAndTVShow, AppError>) in
                switch result {
                case .success(let data):
                    guard let data = data.results else { return }
                    self.similarCollectionDataSource = data.compactMap { SimilarCollectionCellViewModel(similarCollectionData: $0) }
                    self.showInfoData = data
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            break
        }
    }
}
