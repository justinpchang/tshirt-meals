//
//  MealCardView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    var body: some View {
        VStack(alignment: .leading) {
            Text(meal.title)
        }
    }
}
