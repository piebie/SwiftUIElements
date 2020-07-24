//
//  CPTabView.swift
//  iOS App
//
//  Created by Pete Biencourt on 7/17/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI
import SwiftUIElements

struct CPTabView: View {

    @State var selectedItem: CPTabItem
    var barItems: [CPTabItem]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                self.selectedItem.viewContent
                Spacer()
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.barItems) { barItem in
                        Button(action: { self.selectedItem = barItem }) {
                            barItem.tabItemBody
                        }.foregroundColor(self.selectedItem.id == barItem.id ? .accentColor : .secondary)
                            .frame(width: geometry.size.width/CGFloat(self.barItems.count), height: 75)
                    }
                }.frame(width: geometry.size.width, height: 75)
                    .padding(.bottom)
                    .background(Color.white.shadow(radius: 4))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct CPTabItem: Identifiable {
    var id = UUID()
    private(set) var viewContent: AnyView?
    private(set) var tabImage: Image?
    private(set) var tabLabel: Text?

    init<A: View>(@ViewBuilder tabContent: () -> Text, @ViewBuilder viewContent: () -> A) {
        tabLabel = tabContent()
        self.viewContent = AnyView(viewContent())
    }

    var tabItemBody: some View {
        VStack {
            tabImage
            tabLabel
        }
    }
}

struct CPTabView_Previews: PreviewProvider {

    static let tabs = [
        CPTabItem(tabContent: {
            Text("Heyo")
        }, viewContent: {
            Text("Tab 2")
            ProgressBar(progress: 0.5).frame(width: 200)
        }),
//        CPTabItem(tabContent: {
//            Image(systemName: "pencil")
//        }, viewContent: {
//            Text("Tab 1")
//        }),
//        CPTabItem(tabContent: {
//            Text("Boop")
//            Image(systemName: "person")
//        }, viewContent: {
//            Text("Tab 3")
//        }),
//        CPTabItem(tabContent: {
//            Image(systemName: "star")
//            Text("Beep")
//        }, viewContent: {
//            Text("Tab 4")
//        })
    ]

    static var previews: some View {
        CPTabView(selectedItem: tabs[0],
                  barItems: tabs)
    }
}
