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

    static var styles = ["purple": FormattableTextStyle(name: "purple",
                                                        color: .purple),
                         "bold": FormattableTextStyle(name: "bold",
                                                      bold: true),
                         "fancyGreen": FormattableTextStyle(name: "fancyGreen",
                                                            color: .green,
                                                            italics: true)]

    var styleStacks = ["Style": [FormattableTextStyle]()]

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

                if let style = styleStacks["Style"]?.last {
                    currentText = apply(style: style, to: currentText)
                }

                text = text + currentText

            case let .openTag(value):
                // check style
                // push to style stack
                guard let style = FormattableTextModel.styles[value] else {
                    return Text("SOMETHING TERRIBLE HAPPENED")
                }

                styleStacks[style.category]?.append(style)
            case let .closeTag(value):
                guard let style = FormattableTextModel.styles[value] else {
                    return Text("SOMETHING TERRIBLE HAPPENED")
                }

                _ = styleStacks[style.category]?.popLast()
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
