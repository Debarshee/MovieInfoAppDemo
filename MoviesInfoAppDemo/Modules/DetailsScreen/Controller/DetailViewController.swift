//
//  DetailViewController.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/18/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var detailsScrollView: UIScrollView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var coverDescription: UITextView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var availabilityLabel: UILabel!
    @IBOutlet private weak var addToWishlistButton: UIButton!
    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var showBackgroundImageView: UIImageView!
    @IBOutlet private weak var castHeaderLabel: UILabel!
    @IBOutlet private weak var containerBackgroundImageView: UIView!
    @IBOutlet private weak var castCollectionView: UICollectionView! {
        didSet {
            self.castCollectionView.dataSource = self
            self.castCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var similarCollectionView: UICollectionView! {
        didSet {
            self.similarCollectionView.delegate = self
            self.similarCollectionView.dataSource = self
        }
    }
    
    var info: MovieAndTVResults?
    var type: String = ""
    
    lazy var detailViewModel = DetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewModel = DetailViewModel(delegate: self)
        self.title = info?.name ?? info?.originalTitle ?? info?.title ?? ""
        coverDescription.text = info?.overview ?? ""
        releaseDateLabel.text = info?.firstAirDate ?? info?.releaseDate ?? ""
        availabilityLabel.text = String(info?.popularity ?? 0)
        buttonView.layer.cornerRadius = 20
        coverDescription.layer.cornerRadius = 20
        containerBackgroundImageView.layer.cornerRadius = 20
        containerBackgroundImageView.clipsToBounds = true
        guard let imagePath = info?.posterPath else {
            fatalError("Error with image path")
        }
        coverImageView.downloadImage(with: ApiDetails.imageBaseUrl + (imagePath))
        guard let backgroundImagePath = info?.backdropPath else {
            fatalError("Error with image path")
        }
        
        showBackgroundImageView.downloadImage(with: ApiDetails.imageBaseUrl + (backgroundImagePath))
        guard let movieID = info?.id else {
            fatalError("Error with image movie ID")
        }
        
        self.detailViewModel.castCollectionData(dataType: type, movieId: movieID)
        self.detailViewModel.similarCollectionData(dataType: type, movieId: movieID)
    }
    
    @IBAction private func addToWishlistButton(_ sender: UIButton) {
        guard let data = info else { return }
        if !GlobalData.wishlistArray.contains(data) {
            GlobalData.wishlistArray.append(data)
            let alert = UIAlertController(title: "Message", message: "Add to Wishlist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Message", message: "Already in the Wishlist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.similarCollectionView:
            return self.detailViewModel.numberOfRowsInSimilarCollection(section: section)
            
        case self.castCollectionView:
            return self.detailViewModel.numberOfRowsInCastCollection(section: section)
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.castCollectionView:
            guard let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.cellIdentifier, for: indexPath) as? CastCollectionViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let cast = self.detailViewModel.castCollectionShow(at: indexPath.row)
            cell.configure(from: cast)
            return cell
        
        case self.similarCollectionView:
            guard let cell = similarCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.cellIdentifier,
                                                                       for: indexPath) as? SimilarCollectionViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            let similarShow = self.detailViewModel.similarCollectionShow(at: indexPath.row)
            cell.configure(from: similarShow)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        switch collectionView {
        case self.similarCollectionView:
            detailsViewController.info = self.detailViewModel.selectedList(at: indexPath.row)
            detailsViewController.type = self.type
            
        default:
            break
        }
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func castCollectionReloadData() {
        self.castCollectionView.reloadData()
    }
    
    func similarCollectionReloadData() {
        self.similarCollectionView.reloadData()
    }
}
