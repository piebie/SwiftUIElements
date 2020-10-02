//
//  FormattableText.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 10/2/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

public struct FormattableText: View {
    var text: String

    let model = FormattableTextModel()

    private var label: Text

    public init(text: String) {
        self.text = text
        let elements = model.getElements(from: text)
        label = model.getTextFromElements(elements: elements)
    }

    public var body: some View {
        label
    }
}

struct FormattableText_Previews: PreviewProvider {
    static var previews: some View {
        FormattableText(text: "This is a string")
        FormattableText(text: "<purple>This</purple> is a string")
        FormattableText(text: "<fancyGreen>This</fancyGreen> is <bold>a</bold> string")
    }
}
