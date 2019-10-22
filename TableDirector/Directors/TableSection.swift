//
// Created by A on 2019-02-13.
// Copyright (c) 2019 Electronical medicine. All rights reserved.
//

import Foundation

public class TableSection {
    public var rows: [CellBuilder]

    public var title: String?

    public var numberOfRows: Int {
        return rows.count
    }

    public init(rows: [CellBuilder], title: String? = nil) {
        self.rows = rows
        self.title = title
    }
}