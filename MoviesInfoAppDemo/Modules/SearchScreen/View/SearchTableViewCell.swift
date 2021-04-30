//
//  SearchTableViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/13/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell, CellReusable {

    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    
    func configure(from configurator: SearchTableCellViewModel) {
        coverImageView.downloadImage(with: configurator.coverImage)
        nameLabel.text = configurator.name
        infoLabel.text = configurator.releaseDate
        ratingLabel.text = configurator.averageRating
        popularityLabel.text = configurator.popularity
    }
}
