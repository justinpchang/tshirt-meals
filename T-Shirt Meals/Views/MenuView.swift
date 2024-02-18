//
//  MenuView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    
    let meals: [Meal]
    
    var body: some View {
        NavigationView {
            VStack {
                List(meals) { meal in
                    MealCardView(meal: meal)
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                Button {
                    viewModel.isShowingAddMenuMealView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddMenuMealView) {
                AddMenuMealView(isPresented: $viewModel.isShowingAddMenuMealView)
            }
        }
    }
}

#Preview {
    MenuView(meals: Meal.sampleData)
}
