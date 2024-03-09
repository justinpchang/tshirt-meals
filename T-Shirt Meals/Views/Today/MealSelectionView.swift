//
//  MealSelectionView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/2/24.
//

import SwiftUI
import SwiftData

struct MealSelectionView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @Query var meals: [Meal]
    var mealsBySize: [Size: [Meal]] {
        let menuMeals = meals.filter { $0.isInMenu }
        return Dictionary(grouping: menuMeals, by: { $0.size })
    }
    
    @Binding var meal: Meal?
    
    var body: some View {
        VStack {
            List {
                ForEach(Size.allCases, id: \.self) { size in
                    if !(mealsBySize[size]?.isEmpty ?? true) {
                        Section(header: Text(size.rawValue)) {
                            ForEach(mealsBySize[size] ?? []) { _meal in
                                Text(_meal.title)
                                .onTapGesture {
                                    meal = _meal
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .onChange(of: meal) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
