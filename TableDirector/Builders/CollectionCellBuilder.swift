//
// Created by Арабаджиян Артем on 2019-02-11.
// Copyright (c) 2019 Electronical medicine. All rights reserved.
//

import Foundation
import UIKit

open class CollectionCellBuilder<CellType: ConfigurableCell, DataType>: CellBuilder where CellType.DataType == DataType, CellType: UICollectionViewCell {
    public var trailingSwipeActions = [TableRowSwipeBuilder]()

    public var leadingSwipeActions = [TableRowSwipeBuilder]()

    private lazy var actions = [String: [TableRowAction<CellType, DataType>]]()

    public var reuseId: String {
        return String(describing: CellType.self)
    }

    private let item: DataType

    public init(item: DataType) {
        self.item = item
    }

    public init(_ item: DataType) {
        self.item = item
    }

    public init(item: DataType, actions: [TableRowAction<CellType, DataType>]? = nil) {
        self.item = item
        actions?.forEach {
            on($0)
        }
    }

    @discardableResult
    open func on(_ action: TableRowAction<CellType, DataType>) -> Self {

        if actions[action.type.key] == nil {
            actions[action.type.key] = [TableRowAction<CellType, DataType>]()
        }
        actions[action.type.key]?.append(action)

        return self
    }

    public func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }

    public func invoke(action: TableRowActionType, cell: CommonCellMarker?, path: IndexPath, userInfo: [AnyHashable: Any]?) -> Any? {
        return actions[action.key]?.compactMap({
            $0.invokeActionOn(cell: cell as? CellType, item: item, path: path, userInfo: userInfo)
        }).last
    }

    public func has(action: TableRowActionType) -> Bool {
        return actions[action.key] != nil
    }

    public func invoke(action: TableRowActionType, cell: UITableViewCell?, path: IndexPath, userInfo: [AnyHashable: Any]?) -> Any? {
        fatalError("invoke(action:cell:path:userInfo:) has not been implemented")
    }
}