//
//  Banner.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 8/21/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

public struct Banner: ViewModifier {
    public var message: String?

    public init(message: String?) {
        self.message = message
    }

    public func body(content: Content) -> some View {
        content
    }
}

extension View {
    public func presentBanner(with text: String?) -> some View {
        self.modifier(Banner(message: text))
    }
}
