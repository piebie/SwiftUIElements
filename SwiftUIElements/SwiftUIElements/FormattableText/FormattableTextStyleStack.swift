//
//  FormattableTextStyleStack.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 10/9/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import Foundation

class FormattableTextStyleStack {
    static var styles = ["purple": FormattableTextStyle(name: "purple",
                                                        category: "Color",
                                                        color: .purple),
                         "bold": FormattableTextStyle(name: "bold",
                                                      category: "Weight",
                                                      bold: true)]

// TODO: Compound style?
//    "fancyGreen": FormattableTextStyle(name: "fancyGreen",
//    category: "",
//    color: .green,
//    italics: true)

    var styleStacks = [String: [FormattableTextStyle]]()

    func pushStyle(style: FormattableTextStyle) {
        styleStacks[style.category, default: []].append(style)
    }

    func popStyle(category: String) {
        styleStacks[category]?.removeLast()
    }

    func getCurrentStyles() -> [FormattableTextStyle] {
        var styles = [FormattableTextStyle]()

        for category in styleStacks.keys {
            if let currentStyle = styleStacks[category]?.last {
                styles.append(currentStyle)
            }
        }

        return styles
    }
}
