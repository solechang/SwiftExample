//
//  ImageLoader.swift
//  Challenge
//
//  Created by Chang Choi on 8/3/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import UIKit
import RealmSwift

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {
    
    var imageURL: URL?
    
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ url: URL, storeStarWar: StoreStarWar, completion: @escaping (_ inner: () throws -> Void) -> ()) {
        
        // setup activityIndicator...
        self.activityIndicator.color = .white
        
        addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        self.imageURL = url
        
        self.activityIndicator.startAnimating()
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                completion({
                    throw ImageError.imageError })
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    
                } else {
                    completion({
                        throw ImageError.urlNotAvailable })
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
