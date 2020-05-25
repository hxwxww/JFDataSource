//
//  ComposeViewController.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFDataSource

class ComposeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var ads: [[String: Any]] = []
    private var categories: [[String: Any]] = []
    private var activities: [[String: Any]] = []
    private var hotGoods: [[String: Any]] = []

    private let dataSource = TableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupDataSource()
    }
    
    private func fetchData() {
        guard let filePath = Bundle.main.path(forResource: "index", ofType: "json"),
            let json = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let dict = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String: Any],
            let data = dict["data"] as? [String: Any] else {
                return
        }
        ads = data["ads"] as? [[String: Any]] ?? []
        categories = data["category"] as? [[String: Any]] ?? []
        activities = data["activity"] as? [[String: Any]] ?? []
        hotGoods = data["hot_goods"] as? [[String: Any]] ?? []
    }
    
    private func setupDataSource() {
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        let section1 = TableViewSection(items: [ads]) { (tableView, indexPath, ads) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdsCell", for: indexPath) as! AdsCell
            cell.configureCell(ads: ads)
            return cell
        }
        section1.cellHeightProvider = { (_, _, _) in
            return UIScreen.main.bounds.width * 0.5
        }
        
        let section2 = TableViewSection(items: [categories]) { (tableView, indexPath, categories) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.configureCell(categories: categories)
            return cell
        }
        section2.cellHeightProvider = { (_, _, _) in
            return floor(UIScreen.main.bounds.width - 75) / 4 + 30
        }
        
        let section3 = TableViewSection(items: activities) { (tableView, indexPath, activity) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
            cell.configureCell(activity: activity)
            return cell
        }
        section3.cellHeightProvider = { (_, _, _) in
            return UIScreen.main.bounds.width * 0.35
        }
        
        let section4 = TableViewSection(items: hotGoods) { (tableView, indexPath, goods) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsCell", for: indexPath) as! GoodsCell
            cell.configureCell(goods: goods)
            return cell
        }
        section4.cellHeightProvider = { (_, _, _) in
            return 160
        }
        
        dataSource.sections = [section1, section2, section3, section4]
        
    }
}
