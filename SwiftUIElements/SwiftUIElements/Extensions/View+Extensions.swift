//
//  View+Extensions.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 8/7/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

extension View {
    public func syncingHeightIfLarger(than height: Binding<CGFloat?>) -> some View {
        background(
            GeometryReader { geo in
                Color.clear.preference(key: HeightPreferenceKey.self, value: geo.size.height)
            }
        ).onPreferenceChange(HeightPreferenceKey.self) { currentHeight in
            height.wrappedValue = max(height.wrappedValue ?? 0, currentHeight)
        }
    }
}
