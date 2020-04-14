//
//  Feed.swift
//  JFDataSourceExample
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import Foundation

struct Feed {
    let user: String
    let avatar: String
    let content: String
    let date: String
    let image: String?
    
    init(json: [String: Any]) {
        user = json["user"] as? String ?? ""
        avatar = json["avatar"] as? String ?? ""
        content = json["content"] as? String ?? ""
        date = json["date"] as? String ?? ""
        image = json["image"] as? String
    }
    
    static var feedData: [Feed] = {
        guard let filePath = Bundle.main.path(forResource: "feed", ofType: "json"),
            let json = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let jsonArray = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] else {
            return []
        }
        return jsonArray.map(Feed.init(json:))
    }()
    
}
