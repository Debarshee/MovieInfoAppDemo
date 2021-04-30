//
//  SingleTypeCollectionCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

class SingleTypeCollectionCell: UICollectionViewCell, CellReusable {

    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(imageUrl: String, voteAverage: String, title: String, releaseDate: String) {
        coverImageView.downloadImage(with: imageUrl)
        voteAverageLabel.text = voteAverage
        titleLabel.text = title
    }
}
