//
//  SimilarCollectionViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/16/21.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(from configurator: SimilarCollectionCellViewModel) {
        coverImageView.downloadImage(with: configurator.imageUrl)
        voteAverageLabel.text = String(configurator.voteAverage)
        titleLabel.text = configurator.title
    }
}
