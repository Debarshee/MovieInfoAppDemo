//
//  People.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/13/21.
//

import Foundation

struct People: Codable {
    var id: Int?
    var cast: [Cast]?
}

struct Cast: Codable {
    // var adult: Bool
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castId: Int?
    var character: String?
    var creditId: String?
    var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, gender, character, popularity, name, order
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case creditId = "credit_id"
    }
}
