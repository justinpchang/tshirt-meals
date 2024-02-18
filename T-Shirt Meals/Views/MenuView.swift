//
//  MenuView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @State var isShowingAddMenuMealView = false
    @Query var meals: [Meal]
    @Environment(\.modelContext) var modelContext;
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(meals) { meal in
                        MealCardView(meal: meal)
                    }
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                Button {
                    isShowingAddMenuMealView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isShowingAddMenuMealView) {
                AddMenuMealView(isPresented: $isShowingAddMenuMealView)
            }
        }
    }
}

#Preview {
    MenuView()
}
