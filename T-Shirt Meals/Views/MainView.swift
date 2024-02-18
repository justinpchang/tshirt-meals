//
//  MainView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "list.bullet")
                }
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "menucard")
                }
        }
    }
}

#Preview {
    MainView()
}
