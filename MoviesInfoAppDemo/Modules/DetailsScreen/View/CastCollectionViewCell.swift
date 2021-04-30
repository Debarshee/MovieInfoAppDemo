//
//  CastCollectionViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/12/21.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell, CellReusable {
    
    @IBOutlet private weak var castCoverImageView: UIImageView!
    @IBOutlet private weak var castNameLabel: UILabel!
    
    func configure(from configurator: CastCollectionCellViewModel) {
        castCoverImageView.downloadImage(with: configurator.coverImage)
        castCoverImageView.layer.cornerRadius = castCoverImageView.frame.height / 2
        castCoverImageView.clipsToBounds = true
        castNameLabel.text = configurator.castName
    }
}
