//
//  AdsCollectionViewCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var adsImageView: UIImageView!
    
    func configureCell(ad: [String: Any]) {
        if let url = ad["url"] as? String {
            adsImageView.image = UIImage(named: url)
        } else {
            adsImageView.image = nil
        }
    }
}
