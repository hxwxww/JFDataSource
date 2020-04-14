//
//  CategoryCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataSource = CollectionViewDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        let width = floor(UIScreen.main.bounds.width - 75) / 4
        layout.itemSize = CGSize(width: width, height: width + 30)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
    
    func configureCell(categories: [[String: Any]] ) {
        let section = CollectionViewSection(items: categories) { (collectionView, indexPath, category) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configureCell(category: category)
            return cell
        }
        dataSource.sections = [section]
        collectionView.reloadData()
    }
}
