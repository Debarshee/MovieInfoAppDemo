//
//  DoubleTypeCollectionTableViewCell.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

class DoubleTypeCollectionTableViewCell: UITableViewCell, CellReusable {

    @IBOutlet private weak var doubleTypeCollectionLabel: UILabel!
    @IBOutlet private weak var movieCollectionView: UICollectionView! {
        didSet {
            self.movieCollectionView.dataSource = self
            self.movieCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var tvCollectionView: UICollectionView! {
        didSet {
            self.tvCollectionView.dataSource = self
            self.tvCollectionView.delegate = self
        }
    }
    
    // MARK: Declared variable to pass parent view controller onto
    var parent: UIViewController?
    
    // MARK: DataSource for movie collection
    var movieDataSource: MoviesAndTVShow? {
        didSet {
            self.movieCollectionView.reloadData()
        }
    }
    
    // MARK: DataSource for tv collection
    var tvDataSource: MoviesAndTVShow? {
        didSet {
            self.tvCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getPopularTVCollectionData()
        getPopularMovieCollectionData()
    }
    
    // MARK: Get Popular TV Show Data from the API
    private func getPopularTVCollectionData() {
        let url = "https://api.themoviedb.org/3/tv/popular?api_key=0736335c71dad875790ff173cf326a73&language=en-US"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let tvshows):
                self.tvDataSource = tvshows
                
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: Get Popular Movie Data from the API
    private func getPopularMovieCollectionData() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=0736335c71dad875790ff173cf326a73&language=en-US"
        NetworkManager.manager.getData(url: url) { [weak self] (result: Result<MoviesAndTVShow, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movieDataSource = movies
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DoubleTypeCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case movieCollectionView:
            return movieDataSource?.results?.count ?? 0
        
        case tvCollectionView:
            return tvDataSource?.results?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case movieCollectionView:
            guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: DoubleTypeMovieCollectionViewCell.cellIdentifier,
                                                                     for: indexPath) as? DoubleTypeMovieCollectionViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let movie = movieDataSource?.results?[indexPath.row]
            guard let imagePath = movie?.posterPath else {
                fatalError("Error with image path")
            }
            cell.configure(imageUrl: "https://image.tmdb.org/t/p/w500\(imagePath)",
                           voteAverage: String(movie?.voteAverage ?? 0.0) ,
                           title: movie?.originalTitle ?? movie?.name ?? "",
                           releaseDate: movie?.releaseDate ?? movie?.firstAirDate ?? "")
            return cell
            
        case tvCollectionView:
            guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: DoubleTypeTVCollectionViewCell.cellIdentifier,
                                                                  for: indexPath) as? DoubleTypeTVCollectionViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let tv = tvDataSource?.results?[indexPath.row]
            guard let imagePath = tv?.posterPath else {
                fatalError("Error with image path")
            }
            cell.configure(imageUrl: "https://image.tmdb.org/t/p/w500\(imagePath)",
                           voteAverage: String(tv?.voteAverage ?? 0.0) ,
                           title: tv?.originalTitle ?? tv?.name ?? "",
                           releaseDate: tv?.releaseDate ?? tv?.firstAirDate ?? "")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension DoubleTypeCollectionTableViewCell: UICollectionViewDelegate {
    // MARK: Pass on data and type of the selected show for url-endpoints in Detail Screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        switch collectionView {
        case movieCollectionView:
            detailsViewController.info = movieDataSource?.results?[indexPath.row]
            detailsViewController.type = "movie"
            
        case tvCollectionView:
            detailsViewController.info = tvDataSource?.results?[indexPath.row]
            detailsViewController.type = "tv"
            
        default:
            break
        }
        
        parent?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
