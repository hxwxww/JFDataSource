//
//  AdsCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class AdsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let dataSource = CollectionViewDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        let height = width * 0.5
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true

        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    func configureCell(ads: [[String: Any]] ) {
        let section = CollectionViewSection(items: ads) { (collectionView, indexPath, ad) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
            cell.configureCell(ad: ad)
            return cell
        }
        dataSource.sections = [section]
        collectionView.reloadData()
    }
    
}
