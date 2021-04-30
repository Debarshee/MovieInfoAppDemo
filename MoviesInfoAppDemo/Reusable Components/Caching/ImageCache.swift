//
//  ImageCache.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/11/21.
//

import Foundation
import UIKit

final class ImageCache {
    private lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    }()
    
    func saveImage(_ image: UIImage, for url: NSString) {
        imageCache.setObject(image, forKey: url)
    }
    
    func getImage(for url: NSString) -> UIImage? {
        imageCache.object(forKey: url)
    }
}
