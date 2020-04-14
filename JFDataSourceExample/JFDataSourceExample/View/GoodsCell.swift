//
//  GoodsCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class GoodsCell: UITableViewCell {
    
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func configureCell(goods: [String: Any]) {
        if let image = goods["image"] as? String {
            goodsImageView.image = UIImage(named: image)
        } else {
            goodsImageView.image = nil
        }
        nameLabel.text = goods["name"] as? String
        priceLabel.text = "￥" + (goods["price"] as? String ?? "0")
        infoLabel.text = goods["info"] as? String
    }
    
}
