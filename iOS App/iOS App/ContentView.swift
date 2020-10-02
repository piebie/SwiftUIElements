//
//  ContentView.swift
//  iOS App
//
//  Created by Pete Biencourt on 7/17/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI
import SwiftUIElements

struct ContentView : View {
    var body: some View {
        CPTabView(index: 1) {
            CPTabItem(tabContent: {
                Image(systemName: "star")
                Text("Beep")
            }, viewContent: {
                FormattableText(text: "This is a string")
                FormattableText(text: "<purple>This</purple> is a string")
                FormattableText(text: "<fancyGreen>This</fancyGreen> is <bold>a</bold> string")
            })

            CPTabItem(tabContent: {
                Text("Devices")
                Image(systemName: "desktopcomputer")
            }, viewContent: {
                DeviceList()
            })

            CPTabItem(tabContent: {
                Text("Boop")
                Image(systemName: "heart")
                Text("Beep")
                Image(systemName: "gear")
            }, viewContent: {
                Text("Tab 5")
            })
        }.presentBanner(with: "No internet")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
