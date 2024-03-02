//
//  Date.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/2/24.
//

import Foundation

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    
    if Calendar.current.isDateInToday(date) {
        formatter.dateFormat = "h:mm a"
    } else {
        formatter.dateFormat = "MMM d, yyyy h:mm a"
    }
    
    return formatter.string(from: date)
}
