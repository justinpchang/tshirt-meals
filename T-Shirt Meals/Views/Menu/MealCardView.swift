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
                .font(.headline)
            Spacer()
            HStack {
                Label(meal.size.rawValue, systemImage: "tshirt")
                Spacer()
                Label("Last used: ", systemImage: "clock")
                    .padding(.trailing, 20)
            }
        }
        .padding()
    }
}

#Preview {
    MealCardView(meal: Meal.sampleData[0])
        .background(.yellow)
        .previewLayout(.fixed(width: 400, height: 60))
}
