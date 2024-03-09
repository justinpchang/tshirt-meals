//
//  SettingsView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/9/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var meals: [Meal]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Danger Zone")) {
                    Button {
                        do {
                            try modelContext.delete(model: Entry.self)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    } label: {
                        Text("Delete all entries")
                            .foregroundColor(.red)
                    }
                    
                    
                    Button {
                        do {
                            try modelContext.delete(model: Meal.self)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    } label: {
                        Text("Delete all meals")
                            .foregroundColor(.red)
                    }
                
                
                    Button {
                        do {
                            try modelContext.delete(model: BodyWeightEntry.self)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    } label: {
                        Text("Delete all weights")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func deleteAllEntries() {
    }
    
    func deleteAllMeals() {
    }
    
    func deleteAllWeights() {
        do {
            try modelContext.delete(model: BodyWeightEntry.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

#Preview {
    SettingsView()
}
