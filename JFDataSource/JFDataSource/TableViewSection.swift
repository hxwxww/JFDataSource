//
//  TableViewSection.swift
//  JFDataSource
//
//  Created by HongXiangWen on 2020/4/13.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

public protocol TableViewSectionType: UITableViewDataSource, UITableViewDelegate { }

open class TableViewSection<Item>: NSObject, TableViewSectionType, ItemsEditable {
    
    public typealias CellProvider = (UITableView, IndexPath, Item) -> UITableViewCell
    public typealias CellHeightProvider = (UITableView, IndexPath, Item) -> CGFloat
    public typealias CellDidSelect = (UITableView, IndexPath, Item) -> Void
    
    public typealias CellCanEditProvider = (UITableView, IndexPath) -> Bool
    public typealias CellCanMoveProvider = (UITableView, IndexPath) -> Bool
    
    public typealias EditingStyleProvider = (UITableView, IndexPath) -> UITableViewCell.EditingStyle
    
    public typealias CommitEditing = (UITableView, UITableViewCell.EditingStyle, IndexPath) -> Void
    public typealias CommitMoving = (UITableView, IndexPath, IndexPath) -> Void
    
    open var items: [Item]
    open var cellProvider: CellProvider
    open var cellHeightProvider: CellHeightProvider?
    open var cellDidSelect: CellDidSelect?
    
    open var headerTitle: String?
    open var footerTitle: String?
    
    open var headerView: UIView?
    open var footerView: UIView?
    
    open var headerHeight: CGFloat?
    open var footerHeight: CGFloat?
    
    open var cellCanEditProvider: CellCanEditProvider?
    open var cellCanMoveProvider: CellCanMoveProvider?
    
    open var editingStyleProvider: EditingStyleProvider?
    
    open var commitEditing: CommitEditing?
    open var commitMoving: CommitMoving?
    
    public init(items: [Item], cellProvider: @escaping CellProvider) {
        self.items = items
        self.cellProvider = cellProvider
    }
    
    // MARK: -  UITableViewDataSource
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        return cellProvider(tableView, indexPath, item)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return footerTitle
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return cellCanEditProvider?(tableView, indexPath) ?? false
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return cellCanMoveProvider?(tableView, indexPath) ?? false
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(at: indexPath.row)
        }
        commitEditing?(tableView, editingStyle, indexPath)
    }
    
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section == destinationIndexPath.section else {
            fatalError("Error: Cannot move row with different section")
        }
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        commitMoving?(tableView, sourceIndexPath, destinationIndexPath)
    }
    
    // MARK: -  UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        cellDidSelect?(tableView, indexPath, item)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.row]
        return cellHeightProvider?(tableView, indexPath, item) ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let height = headerHeight {
            return height
        } else if let view = headerView {
            return view.frame.height
        } else if let _ = headerTitle {
            return tableView.sectionHeaderHeight
        }
        return 0
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let height = footerHeight {
            return height
        } else if let view = footerView {
            return view.frame.height
        } else if let _ = footerTitle {
            return tableView.sectionFooterHeight
        }
        return 0
    }
    
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return editingStyleProvider?(tableView, indexPath) ?? .delete
    }
}
