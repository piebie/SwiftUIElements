//
//  FormattableTextStyle.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 10/2/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

/*
 {
    name: "bold"
    category: "weight"
    weight: "bold"
 },
 {
    name: "weightBlack"
    category: "weight"
    weight: "black"
 },
 {
    name: "purple"
    category: "color"
    color: "systemPurple"
 */

protocol Style: AnyObject {
    var name: String { get }
    var category: String { get }

    func apply(to text: Text) -> Text
}

class WeightStyle: Style {
    var category: String { "weight" }

    var name: String
    var weight: Font.Weight

    init(name: String,
         weight: Font.Weight) {
        self.name = name
        self.weight = weight
    }

    func apply(to text: Text) -> Text {
        text
            .fontWeight(weight)
    }
}

class ColorStyle: Style {
    var category: String { "color" }

    var name: String
    var color: Color

    init(name: String,
         color: Color) {
        self.name = name
        self.color = color
    }

    func apply(to text: Text) -> Text {
        text
            .foregroundColor(color)
    }
}

struct FormattableTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
