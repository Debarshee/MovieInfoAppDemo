//
//  ProfileCollectionCellViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol ProfileCollectionCellViewModelProtocol {
    var coverImage: String { get }
    var voteAverage: String { get }
    var title: String { get }
}

class ProfileCollectionCellViewModel: ProfileCollectionCellViewModelProtocol {
    
    private var wishlistData: MovieAndTVResults
    
    init(wishlist: MovieAndTVResults) {
        self.wishlistData = wishlist
    }
    
    var coverImage: String {
            "\(ApiDetails.imageBaseUrl)\(self.wishlistData.posterPath ?? "")"
    }
    var voteAverage: String {
            String(self.wishlistData.voteAverage ?? 0)
    }
    var title: String {
            self.wishlistData.name ?? self.wishlistData.originalTitle ?? self.wishlistData.title ?? ""
    }
}
