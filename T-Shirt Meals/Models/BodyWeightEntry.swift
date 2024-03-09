//
//  BodyWeightEntry.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/9/24.
//

import Foundation
import SwiftData

@Model
class BodyWeightEntry: Identifiable {
    var id: UUID
    var date: Date
    var weight: Double
    
    init(id: UUID = UUID(), date: Date = .now, weight: Double) {
        self.id = id
        self.date = date
        self.weight = weight
    }
}
