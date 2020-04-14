//
//  CategoryCollectionViewCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func configureCell(category: [String: Any]) {
        if let url = category["image"] as? String {
            iconImageView.image = UIImage(named: url)
        } else {
            iconImageView.image = nil
        }
        nameLabel.text = category["name"] as? String
    }
}
