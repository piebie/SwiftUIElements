//
//  HeightPreferenceKey.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 8/7/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

public struct HeightPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0

    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        defaultValue = nextValue()
    }
}
