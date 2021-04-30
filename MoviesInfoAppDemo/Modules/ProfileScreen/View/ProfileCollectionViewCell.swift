//
//  ProfileCollectionViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell, CellReusable {
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(from configurator: ProfileCollectionCellViewModelProtocol) {
        coverImageView.downloadImage(with: configurator.coverImage)
        voteAverageLabel.text = configurator.voteAverage
        titleLabel.text = configurator.title
    }
}
