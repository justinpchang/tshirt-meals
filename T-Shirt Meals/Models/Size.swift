//
//  Size.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import Foundation
import SwiftUI

enum Size: String, CaseIterable, Codable {
    case xs = "X-Small"
    case sm = "Small"
    case md = "Medium"
    case lg = "Large"
    case xl = "X-Large"
    
    var abbreviation: String {
        switch self {
        case .xs:
            return "xs"
        case .sm:
            return "sm"
        case .md:
            return "md"
        case .lg:
            return "lg"
        case .xl:
            return "xl"
        }
    }
    
    var sortOrder: Int {
        switch self {
        case .xs: return 0
        case .sm: return 1
        case .md: return 2
        case .lg: return 3
        case .xl: return 4
        }
    }
    
    var color: Color {
        switch self {
        case .xs: return .blue
        case .sm: return .green
        case .md: return .yellow
        case .lg: return .orange
        case .xl: return .red
        }
    }
    
    func tag(count: Int) -> some View {
        let foregroundColor: Color = .white
        let backgroundColor: Color = self.color

        return Text("\(abbreviation) \(count)")
            .font(.headline)
            .padding(8)
            .background(backgroundColor.opacity(0.9))
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
    }
}
