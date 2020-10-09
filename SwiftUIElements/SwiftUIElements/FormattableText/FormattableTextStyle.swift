//
//  FormattableTextStyle.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 10/2/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

protocol Style {
    var name: String { get }
    var category: String { get }

    func apply(to text: Text) -> Text
}

class WeightStyle: Style {
    var name: String { "bold" }
    var category: String { "weight" }

    func apply(to text: Text) -> Text {
        text
            .fontWeight(.bold)
    }
}



struct FormattableTextStyle {
    var name: String
    var category: String
    
    var color = Color.primary
    //var font: Font
    var italics = false
    var bold = false
}
