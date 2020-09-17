//
//  StatusModifier.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 9/1/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

public struct StatusModifier: ViewModifier {
    public enum Status {
        case info
        case error
        case warning
        case success
    }

    @Environment(\.colorScheme) var colorScheme: ColorScheme

    let imageSystemName: String
    let baseColor: Color

    var opacity: Double {
        colorScheme == .light ? 0.1 : 0.25
    }

    public init(imageSystemName: String, baseColor: Color) {
        self.imageSystemName = imageSystemName
        self.baseColor = baseColor
    }

    public func body(content: Content) -> some View {
        HStack {
            Image(systemName: imageSystemName)
            content
        }.padding(4)
        .background(baseColor.opacity(self.opacity))
        .foregroundColor(baseColor)
        .overlay(Rectangle()
                    .frame(height: 1.5)
                    .foregroundColor(baseColor),
                 alignment: .bottom)
    }
}

extension View {
    public func status(imageSystemName: String, baseColor: Color) -> some View {
        self.modifier(StatusModifier(imageSystemName: imageSystemName, baseColor: baseColor))
    }

    public func status(_ status: StatusModifier.Status) -> some View {
        switch status {
        case .error:
            return self.modifier(StatusModifier(imageSystemName: "xmark.octagon.fill", baseColor: .red))
        case .info:
            return self.modifier(StatusModifier(imageSystemName: "info.circle.fill", baseColor: .blue))
        case .warning:
            return self.modifier(StatusModifier(imageSystemName: "exclamationmark.triangle.fill", baseColor: .orange))
        case .success:
            return self.modifier(StatusModifier(imageSystemName: "checkmark.circle.fill", baseColor: .green))
        }

    }
}

struct StatusModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .status(.info)
            Text("Hello, World!").status(.error)
            Text("Hello, World!").status(.success)
            Text("Hello, World!")
                .status(.warning)
            Image(systemName: "person").status(.error)
        }

        VStack {
            Text("Hello, World!").status(.info)
            Text("Hello, World!").status(.error)
            Text("Hello, World!").status(.success)
            Text("Hello, World!")
                .status(.warning)
            Image(systemName: "person").status(.error)
        }
        .preferredColorScheme(.dark)
    }
}
