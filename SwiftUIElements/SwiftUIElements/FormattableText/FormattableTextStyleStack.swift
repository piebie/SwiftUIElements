//
//  FormattableTextStyleStack.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 10/9/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import Foundation

class FormattableTextStyleStack {
    static var styles: [String: Style] = ["purple": ColorStyle(name: "purple",
                                                               color: .purple),
                                          "bold": WeightStyle(name: "bold",
                                                              weight: .bold)]

// TODO: Compound style?
//    "fancyGreen": FormattableTextStyle(name: "fancyGreen",
//    category: "",
//    color: .green,
//    italics: true)

    var styleStacks = [String: [Style]]()

    func pushStyle(style: Style) {
        styleStacks[style.category, default: []].append(style)
    }

    func popStyle(category: String) {
        styleStacks[category]?.removeLast()
    }

    func getCurrentStyles() -> [Style] {
        var styles = [Style]()

        for category in styleStacks.keys {
            if let currentStyle = styleStacks[category]?.last {
                styles.append(currentStyle)
            }
        }

        return styles
    }
}
