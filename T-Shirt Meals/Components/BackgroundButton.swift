//
//  BackgroundButton.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI

struct BackgroundButton: View {
    let title: String
    let background: Color
    let foreground: Color = .white
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(foreground)
                    .bold()
            }
        }
    }
}

#Preview {
    BackgroundButton(title: "Hello", background: .blue) {
        // action
    }
}
