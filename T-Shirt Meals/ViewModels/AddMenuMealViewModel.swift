//
//  AddMenuMealViewModel.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import Foundation

class AddMenuMealViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var size = Size.md
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}
