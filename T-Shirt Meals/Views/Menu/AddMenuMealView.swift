//
//  AddMenuMealView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct AddMenuMealView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var title = ""
    @State var recipe = ""
    @State var size = Size.md
    @State var isInMenu = true
    @State var showAlert = false
    
    var meal: Meal?
    var isEditing: Bool
    var onSave: ((_ meal: Meal) -> Void)?
    
    init(meal: Meal? = nil, onSave: ((_ meal: Meal) -> Void)? = nil) {
        self.meal = meal
        self.isEditing = meal != nil
        self.onSave = onSave
        self._title = State(initialValue: meal?.title ?? "")
        self._recipe = State(initialValue: meal?.recipe ?? "")
        self._size = State(initialValue: meal?.size ?? Size.md)
        self._isInMenu = State(initialValue: true)
    }
    
    var body: some View {
        VStack {
            Form {
                // Title
                TextField("Title", text: $title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Size
                Picker("Size", selection: $size) {
                    ForEach(Size.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                // Recipe
                TextField("Recipe", text: $recipe, axis: .vertical)
                
                if onSave != nil {
                    Toggle("Save to menu?", isOn: $isInMenu)
                        .toggleStyle(SwitchToggleStyle())
                }
                
                // Submit button
                BackgroundButton(title: isEditing ? "Save to menu" : onSave != nil ? "Add" : "Add to menu", background: .blue) {
                    if canSave {
                        save()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields."))
            }
        }
    }
    
    func save() {
        if let existingMeal = meal {
            existingMeal.title = title
            existingMeal.recipe = recipe
            existingMeal.size = size
        } else {
            let meal = Meal(title: title, recipe: recipe, size: size, isInMenu: isInMenu)
            modelContext.insert(meal)
            if onSave != nil {
                onSave!(meal)
            }
        }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}
