//
//  CastCollectionCellViewModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol CastCollectionCellViewModelProtocol {
    var coverImage: String { get }
    var castName: String { get }
}

class CastCollectionCellViewModel: CastCollectionCellViewModelProtocol {
    
    private var castCollectionData: Cast
    
    init(castCollectionData: Cast) {
        self.castCollectionData = castCollectionData
    }
    
    var coverImage: String {
        "\(ApiDetails.imageBaseUrl)\(self.castCollectionData.profilePath ?? "")"
    }
    
    var castName: String {
        self.castCollectionData.name ?? ""
    }
}
