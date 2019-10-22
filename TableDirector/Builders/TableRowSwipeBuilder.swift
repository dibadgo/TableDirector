//
// Created by Арабаджиян Артем on 2019-03-30.
// Copyright (c) 2019 Artem Badgo. All rights reserved.
//

import Foundation
import UIKit

public class TableRowSwipeBuilder {

    public enum SwipeType {
        case trailing
        case leading
    }

    public static let SWIPE_KEY = "swipeKey"

    var swipeType: SwipeType
    let title: String
    let key: String
    let backgroundColor: UIColor
    let image: UIImage?

    var swipeInformation: [String: String] {
        return [TableRowSwipeBuilder.SWIPE_KEY: key]
    }

    public init(swipeType: SwipeType, title: String, key: String, backgroundColor: UIColor, image: UIImage?) {
        self.swipeType = swipeType
        self.title = title
        self.key = key
        self.backgroundColor = backgroundColor
        self.image = image
    }
}

