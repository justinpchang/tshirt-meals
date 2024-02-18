//
//  Meal.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import Foundation

struct Meal: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var size: Size
    
    init(id: UUID = UUID(), title: String, description: String, size: Size) {
        self.id = id
        self.title = title
        self.description = description
        self.size = size
    }
}

extension Meal {
    static let sampleData: [Meal] = [
        Meal(title: "Miso soup", description: "1 cup of boiled water with miso paste", size: .sm),
        Meal(title: "Salad", description: "A large red bowl of salad with lite dressing", size: .md),
        Meal(title: "Pizza", description: "1 serving (2 slices) of pizza from Dominos", size: .lg)
    ]
}
