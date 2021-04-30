//
//  ProfileViewController.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/17/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var wishlistCollectionView: UICollectionView! {
        didSet {
            self.wishlistCollectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileViewModel = ProfileViewModel(delegate: self)
        self.profileViewModel.fetchData()
    }
    
    lazy var profileViewModel = ProfileViewModel(delegate: self)
    
    @IBAction private func clearWishlistButton(_ sender: UIButton) {
        reloadData()
        clearListData()
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.profileViewModel.numberOfRowsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wishlistCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.cellIdentifier, for: indexPath) as? ProfileCollectionViewCell else {
            fatalError("Failed to dequeue the cell")
        }
        let wishlistData = self.profileViewModel.wishlistShow(at: indexPath.row)
        cell.configure(from: wishlistData)
        return cell
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func reloadData() {
        self.wishlistCollectionView.reloadData()
    }
    
    func clearListData() {
        self.profileViewModel.clearListData()
    }
}
