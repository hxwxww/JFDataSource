//
//  ActivityCell.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var activityImageView: UIImageView!
    
    var activity: [String: Any]? {
        didSet {
            guard let activity = activity, let image = activity["image"] as? String else { return }
            activityImageView.image = UIImage(named: image)
        }
    }
    
    func configureCell(activity: [String: Any]) {
        if let image = activity["image"] as? String {
            activityImageView.image = UIImage(named: image)
        } else {
            activityImageView.image = nil
        }
    }
    
}
