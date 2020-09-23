//
//  FormattableTextModel.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 9/23/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

internal class FormattableTextModel {
    enum TextElement {
        case text(String)
        case openTag(String)
        case closeTag(String)
    }

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

//    func getTextFromElements(elements: [TextElement]) -> Text {
//        var text = Text("")
//        for element in elements {
//            switch {
//            case let .text(value):
//
//                var currentText = Text(value)
//                // apply styles
//                text += currentText
//            case let .openTag(value):
//                // check style
//                // push to style stack
//            case let .closeTag(value):
//                // check style
//                // pop from style stack
//            }
//        }
//
//        return text
//    }
}
