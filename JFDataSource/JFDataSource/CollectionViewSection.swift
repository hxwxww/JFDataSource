//
//  CollectionViewSection.swift
//  JFDataSource
//
//  Created by HongXiangWen on 2020/4/14.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

public protocol CollectionViewSectionType: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { }

open class CollectionViewSection<Item>: NSObject, CollectionViewSectionType, ItemsEditable {
    
    public typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell
    public typealias CellSizeProvider = (UICollectionView, UICollectionViewLayout, IndexPath, Item) -> CGSize
    public typealias CellDidSelect = (UICollectionView, IndexPath, Item) -> Void
    
    public typealias HeaderViewProvider = (UICollectionView, String, IndexPath) -> UICollectionReusableView
    public typealias FooterViewProvider = (UICollectionView, String, IndexPath) -> UICollectionReusableView

    public typealias CellCanMoveProvider = (UICollectionView, IndexPath) -> Bool
    public typealias CommitMoving = (UICollectionView, IndexPath, IndexPath) -> Void
    
    public typealias SectionInsetProvider = (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets
    public typealias MinimumLineSpacingProvider = (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
    public typealias MinimumInteritemSpacingProvider = (UICollectionView, UICollectionViewLayout, Int) -> CGFloat
    public typealias HeaderSizeProvider = (UICollectionView, UICollectionViewLayout, Int) -> CGSize
    public typealias FooterSizeProvider = (UICollectionView, UICollectionViewLayout, Int) -> CGSize

    open var items: [Item]
    open var cellProvider: CellProvider
    open var cellSizeProvider: CellSizeProvider?
    open var cellDidSelect: CellDidSelect?
        
    open var headerViewProvider: HeaderViewProvider?
    open var footerViewProvider: FooterViewProvider?

    open var cellCanMoveProvider: CellCanMoveProvider?
    open var commitMoving: CommitMoving?
    
    open var sectionInsetProvider: SectionInsetProvider?
    open var minimumLineSpacingProvider: MinimumLineSpacingProvider?
    open var minimumInteritemSpacingProvider: MinimumInteritemSpacingProvider?
    open var headerSizeProvider: HeaderSizeProvider?
    open var footerSizeProvider: FooterSizeProvider?
    
    public init(items: [Item], cellProvider: @escaping CellProvider) {
        self.items = items
        self.cellProvider = cellProvider
    }
    
    // MARK: -  UICollectionViewDataSource
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        return cellProvider(collectionView, indexPath, item)
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return headerViewProvider!(collectionView, kind, indexPath)
        } else {
            return footerViewProvider!(collectionView, kind, indexPath)
        }
    }

    @available(iOS 9.0, *)
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return cellCanMoveProvider?(collectionView, indexPath) ?? false
    }

    @available(iOS 9.0, *)
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section == destinationIndexPath.section else {
            fatalError("Error: Cannot move row with different section")
        }
        moveItem(from: sourceIndexPath.item, to: destinationIndexPath.item)
        commitMoving?(collectionView, sourceIndexPath, destinationIndexPath)
    }
    
    // MARK: -  UICollectionViewDelegate
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        cellDidSelect?(collectionView, indexPath, item)
    }
    
    // MARK: -  UICollectionViewDelegateFlowLayout
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.item]
        if let size = cellSizeProvider?(collectionView, collectionViewLayout, indexPath, item) {
            return size
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let inset = sectionInsetProvider?(collectionView, collectionViewLayout, section) {
            return inset
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let minimumLineSpacing = minimumLineSpacingProvider?(collectionView, collectionViewLayout, section) {
            return minimumLineSpacing
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let minimumInteritemSpacing = minimumInteritemSpacingProvider?(collectionView, collectionViewLayout, section) {
            return minimumInteritemSpacing
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let headerSize = headerSizeProvider?(collectionView, collectionViewLayout, section) {
            return headerSize
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let footerSize = footerSizeProvider?(collectionView, collectionViewLayout, section) {
            return footerSize
        }
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
