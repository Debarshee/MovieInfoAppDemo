//
//  ProfileViewControllerModel.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/22/21.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData()
}

class ProfileViewModel {

    weak var delegate: ProfileViewModelDelegate?
    private var showInfoData: [MovieAndTVResults]?
    
    private var dataSource: [ProfileCollectionCellViewModel] {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    init(delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
        self.dataSource = []
    }
    
    func fetchData() {
        self.dataSource = GlobalData.wishlistArray.compactMap { ProfileCollectionCellViewModel(wishlist: $0) }
        self.showInfoData = GlobalData.wishlistArray
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        self.dataSource.count
    }
    
    func wishlistShow(at index: Int) -> ProfileCollectionCellViewModel {
        self.dataSource[index]
    }
    
    func selectedList(at index: Int) -> MovieAndTVResults {
        guard let showInfo = self.showInfoData?[index] else {
            fatalError("Info Error")
        }
        return showInfo
    }
    
    func clearListData() {
        self.dataSource.removeAll()
        GlobalData.wishlistArray.removeAll()
    }
}
