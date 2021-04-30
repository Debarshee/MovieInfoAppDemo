//
//  EndPointType.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/29/21.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else {
            fatalError("baseURL could not be configured.") }
        return url
    }
    var httpMethod: HTTPMethod {
        .get
    }
    var headers: HTTPHeaders? {
        nil
    }
}
