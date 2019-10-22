//
// Created by Арабаджиян Артем on 2019-02-12.
// Copyright (c) 2019 Electronical medicine. All rights reserved.
//

import Foundation
import UIKit

open class CollectionDirector: NSObject {

    private(set) weak var collectionView: UICollectionView?
    private(set) var sections = [TableSection]()

    private var reuseIds = Set<String>()
    private var isNeedCellRegister = true

    public init(withCollectionView collectionView: UICollectionView, needCellRegister: Bool = true) {
        super.init()
        collectionView.dataSource = self
        self.isNeedCellRegister = needCellRegister
        self.collectionView = collectionView
    }
}

extension CollectionDirector: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sections.count > section{
            return sections[section].numberOfRows
        } else {
            return 0
        }
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func cellBuilder(forIndexPath indexPath: IndexPath) -> CellBuilder? {
        return sections[indexPath.section].rows[indexPath.row]
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let builder = cellBuilder(forIndexPath: indexPath) else {
            fatalError("Builder for cell is not define")
        }

        if isNeedCellRegister && reuseIds.contains(builder.reuseId) == false{
            collectionView.register(UINib(nibName: builder.reuseId, bundle: nil), forCellWithReuseIdentifier: builder.reuseId)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: builder.reuseId, for: indexPath)

        builder.configure(cell: cell)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        if invoke(action: .click, cell: cell, indexPath: indexPath) != nil {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            invoke(action: .select, cell: cell, indexPath: indexPath)
        }
    }
}

extension CollectionDirector{
    public func append(section: TableSection){
        sections.append(section)
    }

    public func replace(sections: [TableSection]){
        self.sections = sections
    }

    public func clearSections(){
        sections.removeAll()
    }

    public func reloadCollection(){
        collectionView?.reloadData()
    }
}

extension CollectionDirector {
    @discardableResult
    func invoke(
            action: TableRowActionType,
            cell: CommonCellMarker?,
            indexPath: IndexPath,
            userInfo: [AnyHashable: Any]? = nil) -> Any? {
        guard let row = cellBuilder(forIndexPath: indexPath) else {
            return nil
        }
        return row.invoke(
                action: action,
                cell: cell,
                path: indexPath,
                userInfo: userInfo
        )
    }
}


func +=(left: CollectionDirector, right: TableSection){
    left.append(section: right)
}