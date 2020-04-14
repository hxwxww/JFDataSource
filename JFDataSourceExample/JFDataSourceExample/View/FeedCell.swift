//
//  FeedCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/13.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    func configureCell(feed: Feed) {
        avatarImageView.image = UIImage(named: feed.avatar)
        nameLabel.text = feed.user
        infoLabel.text = feed.date
        descLabel.text = feed.content
        if let imageName = feed.image, let image = UIImage(named: imageName){
            feedImageView.image = image
            let width = UIScreen.main.bounds.width - 78
            let height = width * image.size.height / image.size.width
            imageViewHeight.constant = height
        } else {
            feedImageView.image = nil
            imageViewHeight.constant = 0
        }
        layoutIfNeeded()
    }
    
}
