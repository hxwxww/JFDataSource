//
//  ContactsViewController.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class ContactsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataSource = CollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let width = floor(view.bounds.width - 75) / 4
        layout.itemSize = CGSize(width: width, height: width + 36)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 40)
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        let section1 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 1")
        let section2 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 2")
        let section3 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 3")
        
        dataSource.sections = [section1, section2, section3]
    }

    private func buildSection(feeds: [Feed], name: String) -> CollectionViewSection<Feed> {
        let section = CollectionViewSection(items: feeds) { (collectionView, indexPath, feed) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath) as! ContactCell
            cell.configureCell(feed: feed)
            return cell
        }
        section.cellDidSelect = { (collectionView, indexPath, feed) in
            print(feed.user)
        }
        section.headerViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
            header.nameLabel.text = name
            return header
        }
        return section
    }
}
