//
//  ColumnFlowLayout.swift
//  ChangsPlayground
//
//  Created by Chang Choi on 8/1/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    private let minColumnWidth: CGFloat = 300.0
    private let cellHeight: CGFloat = 200.0
    
    
    // MARK: Layout Overrides
    
    /// - Tag: ColumnFlowExample
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        var cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        if maxNumColumns != 1 {
            cellWidth = (availableWidth/2)
            cellWidth = cellWidth - 2
        } else {
            cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        }
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.minimumLineSpacing = 1.0
        self.minimumInteritemSpacing = 1.0
        
    }
}
