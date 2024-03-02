//
//  MenuView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @Environment(\.modelContext) var modelContext;
    
    @Query var meals: [Meal]
    var mealsBySize: [Size: [Meal]] {
        return Dictionary(grouping: meals, by: { $0.size })
    }
    
    @State var isShowingAddMenuMealView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Size.allCases, id: \.self) { size in
                        if !(mealsBySize[size]?.isEmpty ?? true) {
                            Section(header: Text(size.rawValue)) {
                                ForEach(mealsBySize[size] ?? []) { meal in
                                    NavigationLink(destination: EditMenuMealView(meal: meal)) {
                                        MealCardView(meal: meal)
                                    }
                                }
                                .onDelete(perform: deleteMeals)
                            }
                        }
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
    
    func deleteMeals(_ indexSet: IndexSet) {
        for index in indexSet {
            let meal = meals[index]
            modelContext.delete(meal)
        }
    }
}

#Preview {
    MenuView()
}
