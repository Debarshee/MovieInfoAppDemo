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
    
    init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
        self.castCollectionDataSource = []
        self.similarCollectionDataSource = []
    }
    
    func castCollectionData(dataType: String, movieId: Int) {
        let url = "\(ApiDetails.baseUrl)\(dataType)/\(movieId)/credits?api_key=0736335c71dad875790ff173cf326a73&language=en-US"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<People, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data.cast else { return }
                self.castCollectionDataSource = data.compactMap { CastCollectionCellViewModel(castCollectionData: $0) }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func similarCollectionData(dataType: String, movieId: Int) {
        let url = "\(ApiDetails.baseUrl)\(dataType)/\(movieId)/similar?api_key=0736335c71dad875790ff173cf326a73&language=en-US&page=1n-US"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data.results else { return }
                self.similarCollectionDataSource = data.compactMap { SimilarCollectionCellViewModel(similarCollectionData: $0) }
                self.showInfoData = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
}
