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

    init<A: View, B: View>(@ViewBuilder tabContent: () -> B, @ViewBuilder viewContent: () -> A) {
        let topLevelView = tabContent()

        if type(of: topLevelView) == EmptyView.self {
            return
        }

        if let text = topLevelView as? Text {
            tabLabel = text
            return
        }

        if let image = topLevelView as? Image {
            tabImage = image
            return
        }

        let mirror = Mirror(reflecting: topLevelView)

        guard let tuple = mirror.children.first else {
            return
        }

        let tupleMirror = Mirror(reflecting: tuple.value)

        guard tupleMirror.displayStyle == .tuple else {
            return
        }

        let views: [Any] = tupleMirror.children.compactMap { child in
            return child.value as? Text ?? child.value as? Image
        }

        for view in views {
            let text = view as? Text
            let image = view as? Image

            if tabLabel == nil {
                tabLabel = text
            }

            if tabImage == nil {
                tabImage = image
            }
        }

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
            Text("Tab 1")
            ProgressBar(progress: 0.5).frame(width: 200)
        }),
        CPTabItem(tabContent: {
            Image(systemName: "pencil")
        }, viewContent: {
            Text("Tab 2")
        }),
        CPTabItem(tabContent: {
            Text("Boop")
            Image(systemName: "person")
        }, viewContent: {
            Text("Tab 3")
        }),
        CPTabItem(tabContent: {
            Image(systemName: "star")
            Text("Beep")
        }, viewContent: {
            Text("Tab 4")
        }),
        CPTabItem(tabContent: {
            Text("Boop")
            Image(systemName: "heart")
            Text("Beep")
            Image(systemName: "gear")
        }, viewContent: {
            Text("Tab 5")
        })
    ]

    static var previews: some View {
        CPTabView(selectedItem: tabs[0],
                  barItems: tabs)
    }
}
