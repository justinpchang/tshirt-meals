//
//  WeightView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 3/9/24.
//

import SwiftUI
import SwiftData
import SwiftUICharts

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
                    if !weights.isEmpty {
                        LineChart(chartData: chartData)
                    }
                    
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
    
    var chartData: LineChartData {
        let data = LineDataSet(
            dataPoints: weights.reversed().map { entry in
                // Convert the date to a string representation
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d" // Month abbreviation followed by day of the month (e.g., "Mar 17")
                let dateString = dateFormatter.string(from: entry.date)
                
                return LineChartDataPoint(value: entry.weight, xAxisLabel: dateString, description: dateString)
            },
            pointStyle: PointStyle(),
            style: LineStyle(lineColour: ColourStyle(colour: .red), lineType: .curvedLine)
        )
        
        let metadata   = ChartMetadata(title: "Weight")
        
        let gridStyle  = GridStyle(numberOfLines: 7,
                                   lineColour   : Color(.lightGray).opacity(0.5),
                                   lineWidth    : 1,
                                   dash         : [8],
                                   dashPhase    : 0)
        
        let chartStyle = LineChartStyle(infoBoxPlacement    : .infoBox(isStatic: false),
                                        infoBoxBorderColour : Color.primary,
                                        infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
                                        
                                        markerType          : .vertical(attachment: .line(dot: .style(DotStyle()))),
                                        
                                        xAxisGridStyle      : gridStyle,
                                        xAxisLabelPosition  : .bottom,
                                        xAxisLabelColour    : Color.primary,
                                        xAxisLabelsFrom     : .dataPoint(rotation: .degrees(0)),
                                        
                                        yAxisGridStyle      : gridStyle,
                                        yAxisLabelPosition  : .leading,
                                        yAxisLabelColour    : Color.primary,
                                        yAxisNumberOfLabels : 7,
                                        
                                        globalAnimation     : .easeOut(duration: 1))
        
        return LineChartData(dataSets       : data,
                             metadata       : metadata,
                             chartStyle     : chartStyle)   
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
