//
//  QuickAddTableCell.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/20/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import Foundation

import UIKit
import Foundation
import AVKit
import AVFoundation


class QuickAddTableCell: UITableViewCell {
    
//    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
       
}


extension QuickAddTableCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
