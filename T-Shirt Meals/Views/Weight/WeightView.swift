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
    @State var isShowingInput = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    BackgroundButton(title: "Log weigh-in", background: .green) {
                        self.isShowingInput = true
                    }
                    .frame(width: 160, height: 40)
                    
                    List {
                        ForEach(weights) { entry in
                            HStack {
                                Text("\(formatDate(entry.date))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(String(format: "%.2f", entry.weight)) lbs")
                                    .font(.headline)
                            }
                        }
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
