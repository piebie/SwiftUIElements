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
        VStack(spacing: 0) {
            if message != nil {
                Text(message ?? "")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
            }

            content
        }
    }
}

extension View {
    public func presentBanner(with text: String?) -> some View {
        self.modifier(Banner(message: text))
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
