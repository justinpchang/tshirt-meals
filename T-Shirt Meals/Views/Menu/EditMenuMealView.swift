//
//  EditMenuMealView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/25/24.
//

import SwiftUI
import SwiftData

struct EditMenuMealView: View {
    @Bindable var meal: Meal
    
    var body: some View {
        VStack {
            Form {
                // Title
                TextField("Title", text: $meal.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Size
                Picker("Size", selection: $meal.size) {
                    ForEach(Size.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                
                // Recipe
                TextField("Recipe", text: $meal.recipe, axis: .vertical)
                
                .pickerStyle(MenuPickerStyle())
            }
            .navigationTitle("Edit Meal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Meal.self, configurations: config)
        let example = Meal(title: "Packet of ramen", recipe: "Boil water. Add ramen. Add flavor.", size: .md)
        return EditMenuMealView(meal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
