//
//  T_Shirt_MealsApp.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI
import SwiftData

@main
struct T_Shirt_MealsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Meal.self)
    }
}
