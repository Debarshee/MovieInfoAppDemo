//
//  SearchTableCellViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol SearchTableCellViewModelProtocol {
    var coverImage: String { get }
    var name: String { get }
    var releaseDate: String { get }
    var infoId: Int { get }
    var averageRating: String { get }
    var popularity: String { get }
}

class SearchTableCellViewModel: SearchTableCellViewModelProtocol {
    
    private var searchListData: MovieAndTVResults
    
    init(searchListData: MovieAndTVResults) {
        self.searchListData = searchListData
    }
    
    var coverImage: String {
        "\(ApiDetails.imageBaseUrl)\(self.searchListData.posterPath ?? "")"
    }
    
    var name: String {
        self.searchListData.name ?? self.searchListData.originalTitle ?? self.searchListData.title ?? ""
    }
    
    var releaseDate: String {
        self.searchListData.firstAirDate ?? self.searchListData.releaseDate ?? ""
    }
    
    var infoId: Int {
        self.searchListData.id ?? 0
    }
    
    var averageRating: String {
        String(self.searchListData.voteAverage ?? 0)
    }
    
    var popularity: String {
        String(self.searchListData.popularity ?? 0)
    }
}
