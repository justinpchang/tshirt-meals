//
//  AddEntryView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/2/24.
//

import SwiftUI
import SwiftData

struct AddEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var date = Date.now
    @State var meal: Meal?
    @State var showAlert = false
    
    var entry: Entry?
    var isEditing: Bool
    
    init(entry: Entry? = nil) {
        self.entry = entry
        self.isEditing = entry != nil
        self._date = State(initialValue: entry?.date ?? Date.now)
        self._meal = State(initialValue: entry?.meal)
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    DatePicker("Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                }
                
                Section {
                    NavigationLink(destination:
                                    MealSelectionView(meal: $meal)
                                    .navigationBarTitle("Select meal", displayMode: .inline)
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            NavigationLink(destination:
                                                            AddMenuMealView() { meal in
                                                                self.meal = meal
                                                            }
                                                            .navigationBarTitle("Create meal", displayMode: .inline)
                                            ) {
                                                Text("Create")
                                            }
                                        }
                                    }
                    ) {
                        HStack {
                            if let meal = meal {
                                Text("\(meal.title) (\(meal.size.rawValue))")
                            } else {
                                Text("Choose a meal")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                BackgroundButton(title: isEditing ? "Save" : "Add", background: .blue) {
                    if canSave {
                        save()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert = true
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields."))
            }
        }
    }
    
    func save() {
        if let existingEntry = entry {
            existingEntry.date = date
            existingEntry.meal = meal!
        } else {
            let entry = Entry(date: date, meal: meal!)
            modelContext.insert(entry)
        }
    }
    
    var canSave: Bool {
        guard meal != nil else {
            return false
        }
        
        return true
    }
}
