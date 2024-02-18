//
//  Meal.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import Foundation
import SwiftData

@Model
class Meal: Identifiable {
    var id: UUID
    var title: String
    var recipe: String
    var size: Size
    
    init(id: UUID = UUID(), title: String, recipe: String, size: Size) {
        self.id = id
        self.title = title
        self.recipe = recipe
        self.size = size
    }
}

extension Meal {
    static let sampleData: [Meal] = [
        Meal(title: "Miso soup", recipe: "1 cup of boiled water with miso paste", size: .sm),
        Meal(title: "Salad", recipe: "A large red bowl of salad with lite dressing", size: .md),
        Meal(title: "Pizza", recipe: "1 serving (2 slices) of pizza from Dominos", size: .lg)
    ]
}
