//
//  StarWarsCollectionViewCell.swift
//  Challenge
//
//  Created by Chang Choi on 8/3/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import UIKit

class StarWarsCollectionViewCell: UICollectionViewCell {
    static let identifier = "starwarsCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starWarsImageView: ImageLoader!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var location1Label: UILabel!
    
    @IBOutlet weak var location2Label: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    var starWar: StoreStarWar? {
        didSet {
            guard let aStarWar = starWar else { return }
            
            self.titleLabel.text = aStarWar.title
            self.dateLabel.text = aStarWar.date
           
            let url = URL(string: aStarWar.image ?? "")
            if let url = url {
                self.starWarsImageView.loadImageWithUrl(url, storeStarWar: aStarWar) { (inner: () throws -> Void) -> Void in
                    do {
                        try inner()
                    } catch let error {
                        // Error handling unavailable Image
                        DispatchQueue.main.async {
                            self.starWarsImageView.image = UIImage(named: "placeHolder")
                        }
                        print("Error: \(error)")
                    }
                }
            } else {
                // IMAGE URL IS NULL
                self.starWarsImageView.image = UIImage(named: "placeHolder")
            }
    
            self.location1Label.text = aStarWar.locationline1
            self.location2Label.text = aStarWar.locationline2
            self.phoneNumberLabel.text = aStarWar.phone ?? ""

        }
    }

}

