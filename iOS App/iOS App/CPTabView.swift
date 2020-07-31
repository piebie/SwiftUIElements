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

    @State var selectedIndex: Int
    var barItems: [CPTabItem]

    init<A: View>(index: Int = 0, @ViewBuilder tabItems: () -> A) {
        let topLevelView = tabItems()

        _selectedIndex = State(initialValue: 0)
        barItems = [CPTabItem(tabContent: { EmptyView() }, viewContent: { EmptyView() })]

        if type(of: topLevelView) == EmptyView.self {
            return
        }

        if let tabItem = topLevelView as? CPTabItem {
            barItems = [tabItem]
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

        let views: [CPTabItem] = tupleMirror.children.compactMap { child in
            return child.value as? CPTabItem
        }

        if views.isEmpty {
            return
        }

        barItems = views
        _selectedIndex = State(initialValue: max(0, index < barItems.count ? index : 0))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                self.barItems[self.selectedIndex]
                Spacer()
                HStack(alignment: .top, spacing: 0) {
                    ForEach(0 ..< self.barItems.count) { index in
                        Button(action: { self.selectedIndex = index }) {
                            self.barItems[index].tabItemBody
                        }.foregroundColor(self.selectedIndex == index ? .accentColor : .secondary)
                            .frame(width: geometry.size.width/CGFloat(self.barItems.count), height: 75)
                    }
                }.frame(width: geometry.size.width, height: 75)
                    .padding(.bottom)
                    .background(Color.white.shadow(radius: 4))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct CPTabItem: View, Identifiable {
    var id = UUID()
    private var viewContent: AnyView?
    private(set) var tabImage: Image?
    private(set) var tabLabel: Text?

    init<A: View, B: View>(@ViewBuilder tabContent: () -> B, @ViewBuilder viewContent: () -> A) {
        self.viewContent = AnyView(viewContent())

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
    }

    var body: some View {
        viewContent
    }

    var tabItemBody: some View {
        VStack {
            tabImage
            tabLabel
        }
    }
}

struct CPTabView_Previews: PreviewProvider {
    static var previews: some View {
        CPTabView(index: 10) {
            CPTabItem(tabContent: {
                Text("Heyo")
            }, viewContent: {
                VStack {
                    Text("Tab 1")
                    ProgressBar(progress: 0.5).frame(width: 200)
                }
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
