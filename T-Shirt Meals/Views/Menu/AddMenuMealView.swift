//
//  AddMenuMealView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct AddMenuMealView: View {
    @Environment(\.modelContext) var modelContext;
    
    @State var title = ""
    @State var recipe = ""
    @State var size = Size.md
    @State var showAlert = false
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Meal")
                .font(.system(size: 32))
                .bold()
                .padding()
            
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
                
                // Submit button
                BackgroundButton(title: "Add to menu", background: .blue) {
                    if canSave {
                        save()
                        isPresented = false
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
        let meal = Meal(title: title, recipe: recipe, size: size)
        modelContext.insert(meal)
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard !recipe.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}

#Preview {
    AddMenuMealView(isPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
