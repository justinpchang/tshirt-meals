//
//  Entry.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/2/24.
//

import Foundation
import SwiftData

@Model
class Entry: Identifiable {
  var id: UUID
  var date: Date
  var meal: Meal

  init(id: UUID = UUID(), date: Date = .now, meal: Meal) {
    self.id = id
    self.date = date
    self.meal = meal
  }
}
