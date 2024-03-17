//
//  WeightView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/9/24.
//

import SwiftUI
import SwiftData

struct WeightView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \BodyWeightEntry.date, order: .reverse) var weights: [BodyWeightEntry]
    
    @State var weightInput: String = ""
    @FocusState var isWeightInputFocused: Bool
    @State var isShowingInput = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(weights) { entry in
                            HStack {
                                Text("\(formatDate(entry.date))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(Int(entry.weight)) lbs")
                                    .font(.headline)
                            }
                        }
                    }
                }
                .navigationTitle("Weight")
                .toolbar {
                    Button {
                        isShowingInput = true
                        isWeightInputFocused = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                if isShowingInput {
                    ZStack {
                        Color(.systemBackground)
                            .opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.isShowingInput = false
                                self.weightInput = ""
                            }
                        
                        VStack {
                            TextField("Enter your weight", text: $weightInput)
                                .focused($isWeightInputFocused)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                .keyboardType(.numberPad)
                            
                            Button("Add weight", action: addWeight)
                                .padding(5)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
                    .onAppear {
                        self.weightInput = ""
                    }
                }
            }
        }
    }
    
    private func addWeight() {
        guard let weight = Double(weightInput) else { return }
        let newEntry = BodyWeightEntry(weight: weight)
        modelContext.insert(newEntry)
        weightInput = ""
        isShowingInput = false
    }
}

#Preview {
    WeightView()
}
