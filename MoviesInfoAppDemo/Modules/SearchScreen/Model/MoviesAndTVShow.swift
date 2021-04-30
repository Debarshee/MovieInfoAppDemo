//
//  MoviesAndTVShow.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/13/21.
//

import Foundation

struct MoviesAndTVShow: Decodable {
    var page: Int?
    var results: [MovieAndTVResults]?
    var totalPages: Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieAndTVResults: Decodable, Equatable {
    var id: Int?
    var name: String?
    var originalLanguage: String?
    var originalTitle: String?
    var posterPath: String?
    // var video: Bool
    var voteAverage: Double?
    var overview: String?
    var releaseDate: String?
    var voteCount: Int?
    // var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]?
    var title: String?
    var popularity: Double?
    var mediaType: String?
    var firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title, popularity, name
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
    }
}
