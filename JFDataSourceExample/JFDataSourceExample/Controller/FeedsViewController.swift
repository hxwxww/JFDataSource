//
//  FeedsViewController.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class FeedsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        let section1 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 1")
        let section2 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 2")
        let section3 = buildSection(feeds: Feed.feedData.shuffled(), name: "Section 3")

        dataSource.sections = [section1, section2, section3]
    }
    
    private func buildSection(feeds: [Feed], name: String) -> TableViewScection<Feed> {
        let section = TableViewScection(items: feeds) { (tableView, indexPath, feed) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.configureCell(feed: feed)
            return cell
        }
        section.cellDidSelect = { (tableView, indexPath, feed) in
            tableView.deselectRow(at: indexPath, animated: true)
            print(feed.user)
        }
        section.headerTitle = name
        
        return section
    }
    
}
