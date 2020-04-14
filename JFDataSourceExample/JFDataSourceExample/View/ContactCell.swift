//
//  ContactCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/13.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(feed: Feed) {
        avatarImageView.image = UIImage(named: feed.avatar)
        nameLabel.text = feed.user
    }
}
