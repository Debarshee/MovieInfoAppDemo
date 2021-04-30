//
//  SingleCollectionTableViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

protocol SingleTypeCollectionTableViewCellDelegate: AnyObject {
    func getParentViewController() -> UIViewController
}

class SingleTypeCollectionTableViewCell: UITableViewCell, CellReusable {

    @IBOutlet private weak var singleCollectionTableViewLabel: UILabel!
    @IBOutlet private weak var singleCollectionSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var singleCollectionView: UICollectionView! {
        didSet {
            self.singleCollectionView.dataSource = self
            self.singleCollectionView.delegate = self
        }
    }
    weak var delegate: SingleTypeCollectionTableViewCellDelegate?
    var streamingType = ""
    var singleCollectionDataSource: MoviesAndTVShow? {
        didSet {
            self.singleCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        singleCollectionSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        singleCollectionSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        getData()
    }
    
    @IBAction private func selectedSegmentedControl(_ sender: UISegmentedControl) {
        getData()
    }
    private func getData() {
        var url = ""
        switch singleCollectionSegmentedControl.selectedSegmentIndex {
        case 0:
            streamingType = "movie"
            url = "https://api.themoviedb.org/3/movie/now_playing?api_key=0736335c71dad875790ff173cf326a73&language=en-US&page=1"
            
        default:
            streamingType = "tv"
            url = "https://api.themoviedb.org/3/tv/on_the_air?api_key=0736335c71dad875790ff173cf326a73&language=en-US&page=1"
        }
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let shows):
                self.singleCollectionDataSource = shows
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SingleTypeCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        singleCollectionDataSource?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = singleCollectionView.dequeueReusableCell(withReuseIdentifier: SingleTypeCollectionCell.cellIdentifier,
                                                                  for: indexPath) as? SingleTypeCollectionCell else {
            fatalError("Failed to dequeue the cell")
        }
        let streamingData = singleCollectionDataSource?.results?[indexPath.row]
        guard let imagePath = streamingData?.posterPath else {
            fatalError("Error with image path")
        }
        cell.configure(imageUrl: "https://image.tmdb.org/t/p/w500\(imagePath)",
                       voteAverage: String(streamingData?.voteAverage ?? 0.0) ,
                       title: streamingData?.originalTitle ?? streamingData?.name ?? "",
                       releaseDate: streamingData?.releaseDate ?? streamingData?.firstAirDate ?? "")
        return cell
    }
}

extension SingleTypeCollectionTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        // detailsViewController.info = singleCollectionDataSource?.results?[indexPath.row]
        detailsViewController.type = streamingType
        let parent = self.delegate?.getParentViewController()
        parent?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
