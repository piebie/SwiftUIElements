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
        CPTabView(index: 2) {
            CPTabItem(tabContent: {
                Text("Heyo it's me today")
            }, viewContent: {
                Text("Tab 1")
                ProgressBar(progress: 0.5).frame(width: 200)
            })

            CPTabItem(tabContent: {
                Image(systemName: "pencil")
            }, viewContent: {
                Text("Tab 2")
            })

            CPTabItem(tabContent: {
                Text("Boop")
                Image(systemName: "person")
            }, viewContent: {
                Text("Tab 3")
            })

            CPTabItem(tabContent: {
                Image(systemName: "star")
                Text("Beep")
            }, viewContent: {
                Text("Tab 4")
            })

            CPTabItem(tabContent: {
                Text("Boop")
                Image(systemName: "heart")
                Text("Beep")
                Image(systemName: "gear")
            }, viewContent: {
                Text("Tab 5")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
