//
//  ItemsEditable.swift
//  JFDataSource
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import Foundation

public protocol ItemsEditable: class {
    
    associatedtype Item
    
    var items: [Item] { get set }

    func deleteItem(at index: Int)
    
    func insertItem(_ item: Item, at index: Int)
    
    func moveItem(from sourceIndex: Int, to destinationIndex: Int)
}

extension ItemsEditable {
    
    public func deleteItem(at index: Int) {
        items.remove(at: index)
    }
    
    public func insertItem(_ item: Item, at index: Int) {
        items.insert(item, at: index)
    }
    
    public func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        let item = items.remove(at: sourceIndex)
        items.insert(item, at: destinationIndex)
    }
}
