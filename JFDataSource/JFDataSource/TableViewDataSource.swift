//
//  TableViewDataSource.swift
//  JFDataSource
//
//  Created by HongXiangWen on 2020/4/13.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

open class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public typealias SectionIndexTitles = (UITableView) -> [String]?
    public typealias SectionForSectionIndex = (UITableView, String, Int) -> Int
    
    open var sections: [TableViewSectionType]
    
    open var sectionIndexTitles: SectionIndexTitles?
    open var sectionForSectionIndex: SectionForSectionIndex?
    
    public init(sections: [TableViewSectionType] = []) {
        self.sections = sections
    }
    
    // MARK: -  UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].tableView?(tableView, titleForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].tableView?(tableView, titleForFooterInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].tableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].tableView?(tableView, canMoveRowAt: indexPath) ?? false
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        sections[indexPath.section].tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section == destinationIndexPath.section else {
            fatalError("Error: Cannot move row with different section")
        }
        sections[sourceIndexPath.section].tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndexTitles?(tableView)
    }

    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionForSectionIndex?(tableView, title, index) ?? index
    }
    
    // MARK: -  UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].tableView?(tableView, viewForFooterInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].tableView?(tableView, heightForFooterInSection: section) ?? 0
    }
    
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return sections[indexPath.section].tableView?(tableView, editingStyleForRowAt: indexPath) ?? .delete
    }
}
