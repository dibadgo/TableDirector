//
// Created by A on 2019-02-11.
// Copyright (c) 2019 Electronical medicine. All rights reserved.
//

import Foundation
import UIKit

public protocol CellBuilder {

    var reuseId: String { get }

    var trailingSwipeActions: [TableRowSwipeBuilder] { get }
    var leadingSwipeActions: [TableRowSwipeBuilder] { get }

    func configure(cell: UIView)

    func invoke(
            action: TableRowActionType,
            cell: CommonCellMarker?,
            path: IndexPath,
            userInfo: [AnyHashable: Any]?) -> Any?

    func has(action: TableRowActionType) -> Bool
}
