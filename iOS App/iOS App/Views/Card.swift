//
//  CardView.swift
//  iOS App
//
//  Created by Pete Biencourt on 9/2/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI
import SwiftUIElements

struct Card<Content>: View where Content: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .padding(.vertical, 8)
            .background(Color.white.cornerRadius(8).shadow(radius: 5))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth:1.0))

    }
}

struct DeviceList: View {
    let devices: [(name: String, status: StatusModifier.Status, message: String)] =
        [(name: "piebie-trashcan", status: .info, message: "Current device"),
         (name: "MacPro", status: .error, message: "Out of compliance"),
         (name: "New Mac", status: .success, message: "Enrolled"),
         (name: "piebie-trashcan", status: .info, message: "Current device"),
         (name: "MacPro", status: .error, message: "Out of compliance"),
         (name: "New Mac", status: .success, message: "Enrolled")]

    var body: some View {
        VStack {
            Text("My devices (\(devices.count))")
                .font(.title)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding(.horizontal)

            ScrollView {
                VStack(spacing: 25) {
                    ForEach(0..<devices.count) { index in
                        Card {
                            VStack(spacing: 10) {
                                Text(devices[index].name)
                                    .lineLimit(1)
                                    .padding(.horizontal)
                                Image(systemName: "desktopcomputer")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                Text(devices[index].message)
                                    .frame(maxWidth: .infinity,
                                           alignment: .leading)
                                    .status(devices[index].status)
                            }
                        }.padding(.horizontal, 50)
                    }
                }.padding(.vertical, 20)
            }.frame(maxWidth: .infinity)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList()
    }
}
