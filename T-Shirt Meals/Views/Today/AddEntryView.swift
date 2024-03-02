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
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        DatePicker("Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.compact)
                    }
                    
                    Section {
                        NavigationLink(destination: MealSelectionView(meal: $meal)) {
                            HStack {
                                Text("Select Meal")
                                Spacer()
                                Text(meal?.title ?? "Choose a meal")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields."))
                }
            }
            .navigationTitle("Add entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if canSave {
                            save()
                            isPresented = false
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    func save() {
        let entry = Entry(date: date, meal: meal!)
        modelContext.insert(entry)
    }
    
    var canSave: Bool {
        guard meal != nil else {
            return false
        }
        
        return true
    }
}
