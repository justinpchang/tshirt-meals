//
//  TutorialView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/17/24.
//

import SwiftUI

struct TutorialView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Welcome to T-Shirt Meals!")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            
            Text("In this app, you can track your meals using T-Shirt sizes (small, medium, large, etc.) instead of counting calories.")
                .font(.body)
                .padding()
            
            Text("Add your staples to your menu and presize them, then you can log them in the Today tab. You can also 'Quick Add' a meal by unchecking the 'Save to menu' option when adding a meal from the Today tab.")
                .font(.body)
                .padding()
            
            Text("If you would like to track your weight over time, you can do so in the Weight tab.")
                .font(.body)
                .padding()
            
            Text("HINT: You can always trigger this tutorial again via the Settings tab.")
                .font(.body)
                .padding()
            
            Spacer()
            
            Button(action: dismissTutorial) {
                Text("Enjoy your meals!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
        .multilineTextAlignment(.center)
    }
    
    func dismissTutorial() {
        isPresented = false
    }
}

