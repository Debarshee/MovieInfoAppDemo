//
//  SimilarCollectionCellViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol SimilarCollectionCellViewModelProtocol {
    var imageUrl: String { get }
    var voteAverage: String { get }
    var title: String { get }
}

class SimilarCollectionCellViewModel: SimilarCollectionCellViewModelProtocol {
    
    private var similarCollectionData: MovieAndTVResults
    
    init(similarCollectionData: MovieAndTVResults) {
        self.similarCollectionData = similarCollectionData
    }
    
    var imageUrl: String {
        "\(ApiDetails.imageBaseUrl)\(self.similarCollectionData.posterPath ?? "")"
    }
    
    var voteAverage: String {
        String(self.similarCollectionData.voteAverage ?? 0)
    }
    
    var title: String {
        self.similarCollectionData.name ?? self.similarCollectionData.originalTitle ?? self.similarCollectionData.title ?? ""
    }
}
