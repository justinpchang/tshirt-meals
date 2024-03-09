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
        let menuMeals = meals.filter { $0.isInMenu }
        return Dictionary(grouping: menuMeals, by: { $0.size })
    }
    
    @State var isShowingAddMenuMealView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Size.allCases, id: \.self) { size in
                        if !(mealsBySize[size]?.isEmpty ?? true) {
                            Section(header: HStack {
                                Label(size.rawValue, systemImage: "tshirt").font(.headline).foregroundStyle(.primary)
                            }) {
                                ForEach(mealsBySize[size] ?? []) { meal in
                                    NavigationLink(destination: AddMenuMealView(meal: meal).navigationBarTitle("Edit meal", displayMode: .inline)) {
                                        MealCardView(meal: meal)
                                    }
                                }
                                .onDelete(perform: deleteMeals)
                            }
                        }
                    }
                }
                .listStyle(.plain)
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
                AddMenuMealView().navigationBarTitle("Add meal", displayMode: .inline)
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
