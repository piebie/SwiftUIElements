//
//  FormattableTextModel.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 9/23/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

internal class FormattableTextModel {
    enum TextElement {
        case text(String)
        case openTag(String)
        case closeTag(String)
    }

    private let styleStack = FormattableTextStyleStack()

    func getElements(from formatString: String) -> [TextElement] {
        var result = [TextElement]()

        var currentElementValue = ""
        var isInTag = false
        var isInCloseTag = false
        for currentCharacter in formatString {
            if currentCharacter == "<" {
                guard !isInTag else {
                    return [.text(formatString)]
                }

                if !currentElementValue.isEmpty {
                    result.append(TextElement.text(currentElementValue))
                }

                currentElementValue = ""

                isInTag = true

            } else if currentCharacter == "/" {
                guard !isInCloseTag,
                      currentElementValue.isEmpty else {
                    return [.text(formatString)]
                }

                isInCloseTag = true

            } else if currentCharacter == ">"{
                guard isInTag,
                      !currentElementValue.isEmpty else {
                    return [.text(formatString)]
                }

                let element = isInCloseTag ? TextElement.closeTag(currentElementValue) : TextElement.openTag(currentElementValue)

                result.append(element)

                isInTag = false
                isInCloseTag = false

                currentElementValue = ""
            } else {
                currentElementValue += String(currentCharacter)
            }
        }

        guard !isInTag else {
            return [.text(formatString)]
        }

        if !currentElementValue.isEmpty {
            result.append(TextElement.text(currentElementValue))
        }

        return result
    }

    func getTextFromElements(elements: [TextElement]) -> Text {
        var text = Text("")
        for element in elements {
            switch element {
            case let .text(value):
                var currentText = Text(value)

                for style in styleStack.getCurrentStyles() {
                    currentText = style.apply(to: currentText)
                }

                text = text + currentText

            case let .openTag(value):
                // check style
                // push to style stack
                guard let style = FormattableTextStyleStack.styles[value] else {
                    return Text("SOMETHING TERRIBLE HAPPENED")
                }

                styleStack.pushStyle(style: style)
            case let .closeTag(value):
                guard let style = FormattableTextStyleStack.styles[value] else {
                    return Text("SOMETHING TERRIBLE HAPPENED")
                }

                styleStack.popStyle(category: style.category)
            }
        }

        return text
    }

    func apply(style: FormattableTextStyle, to text: Text) -> Text {
        var text = text
        if style.italics {
            text = text.italic()
        }

        return text
            .fontWeight(style.bold ? .bold : .regular)
            .foregroundColor(style.color)
    }
}

struct FormattableTextModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
