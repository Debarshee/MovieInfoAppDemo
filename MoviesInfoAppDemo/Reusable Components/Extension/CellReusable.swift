//
//  CellReusable.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/11/21.
//

import Foundation

protocol CellReusable {
    static var cellIdentifier: String { get }
}

extension CellReusable {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
