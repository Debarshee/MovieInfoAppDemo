//
//  MovieApi.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/29/21.
//

import Foundation

enum MovieApi {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
    case movieDetails(id: Int)
    case tvDetails(id: Int)
    case movieCasts(id: Int)
    case tvCasts(id: Int)
    case searchMovie(page: Int, query: String)
    case searchTV(page: Int, query: String)
}

extension MovieApi: EndPointType {
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "movie/\(id)/recommendations"
        case .popular:
            return "movie/popular"
        case .newMovies:
            return "movie/now_playing"
        case .video(let id):
            return "movie/\(id)/videos"
        case .movieDetails(let id):
            return "movie/\(id)"
        case .tvDetails(let id):
            return "tv/\(id)"
        case .movieCasts(let id):
            return "movie/\(id)/credits"
        case .tvCasts(let id):
            return "tv/\(id)/credits"
        case .searchMovie:
            return "search/movie"
        case .searchTV:
            return "search/tv"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
        
        case .movieDetails:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case .tvDetails:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case .movieCasts:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case .tvCasts:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case let .searchMovie(page, query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "query": query,
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
            
        case let .searchTV(page, query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "query": query,
                                        "api_key": "0736335c71dad875790ff173cf326a73"
                                      ]
            )
        
        default:
            return .request
        }
    }
}
