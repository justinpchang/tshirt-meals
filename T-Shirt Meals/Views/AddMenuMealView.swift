//
//  AddMenuMealView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct AddMenuMealView: View {
    @StateObject var viewModel = AddMenuMealViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Meal")
                .font(.system(size: 32))
                .bold()
                .padding()
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Description
                TextField("Description/Recipe", text: $viewModel.description)
                
                // Size
                Picker("Size", selection: $viewModel.size) {
                    ForEach(Size.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                // Submit button
                BackgroundButton(title: "Add to menu", background: .blue) {
                    if viewModel.canSave {
                        viewModel.save()
                        isPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields."))
            }
        }
    }
}

#Preview {
    AddMenuMealView(isPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
