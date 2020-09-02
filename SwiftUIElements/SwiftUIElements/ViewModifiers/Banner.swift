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
        ZStack(alignment: .top) {
            content

            if message != nil {
                Text(message ?? "")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(8)
                    .padding(10)
            }
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
        Color.blue.opacity(0.3).presentBanner(with: "Hello, World!")
    }
}
