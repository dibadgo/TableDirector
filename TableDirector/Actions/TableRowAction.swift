//
// Created by A on 2019-02-22.
// Copyright (c) 2019 Electronical medicine. All rights reserved.
//

import Foundation
import UIKit

public class TableRowActionOptions<CellType: ConfigurableCell, CellData> where CellType.DataType == CellData {

    public let item: CellData
    public let cell: CellType?
    public let indexPath: IndexPath
    public let userInfo: [AnyHashable: Any]?

    public var swipeInfo: String? {
        if let userInfo = userInfo,
           userInfo.keys.contains(TableRowSwipeBuilder.SWIPE_KEY),
           let key = userInfo[TableRowSwipeBuilder.SWIPE_KEY] as? String {
            return key
        } else {
            return nil
        }
    }

    init(item: CellData, cell: CellType?, path: IndexPath, userInfo: [AnyHashable: Any]?) {

        self.item = item
        self.cell = cell
        self.indexPath = path
        self.userInfo = userInfo
    }
}

private enum TableRowActionHandler<CellType: ConfigurableCell, CellData> where CellType.DataType == CellData {

    case voidAction((TableRowActionOptions<CellType, CellData>) -> Void)
    case action((TableRowActionOptions<CellType, CellData>) -> Any?)

    func invoke(withOptions options: TableRowActionOptions<CellType, CellData>) -> Any? {

        switch self {
        case .voidAction(let handler):
            return handler(options)
        case .action(let handler):
            return handler(options)
        }
    }
}

public class TableRowAction<CellType: ConfigurableCell, CellData> where CellType.DataType == CellData {

    private(set) var id: String?
    let type: TableRowActionType
    private let handler: TableRowActionHandler<CellType, CellData>

    public init(_ type: TableRowActionType, handler: @escaping (_ options: TableRowActionOptions<CellType, CellData>) -> Void) {

        self.type = type
        self.handler = .voidAction(handler)
    }

    init<T>(_ type: TableRowActionType, handler: @escaping (_ options: TableRowActionOptions<CellType, CellData>) -> T) {

        self.type = type
        self.handler = .action(handler)
    }

    func invokeActionOn(cell: CommonCellMarker?, item: CellData, path: IndexPath, userInfo: [AnyHashable: Any]?) -> Any? {
        return handler.invoke(withOptions: TableRowActionOptions(item: item, cell: cell as? CellType, path: path, userInfo: userInfo))
    }
}


public enum TableRowActionType {

    case click
    case select
    case trailingSwipe
    case leadingSwipe

    var key: String {
        return "_\(self)"
    }
}