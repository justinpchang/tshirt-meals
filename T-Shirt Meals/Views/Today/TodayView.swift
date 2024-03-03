//
//  TodayView.swift
//  T-Shirt Meals
//
//  Created by Justin Chang on 2/18/24.
//

import SwiftUI
import SwiftData

let ONE_DAY = 24.0 * 60 * 60

struct TodayView: View {
    @Environment(\.modelContext) var modelContext;
    
    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]
    
    @State var date = Date()
    @State var isShowingAddEntryView = false
    @State var isShowingDatePicker = false
    
    var mealCountBySize: [Size: Int] {
        var counts: [Size: Int] = [:]
        
        // Iterate through entries and count meals by size
        entries.forEach { entry in
            if Calendar.current.isDate(entry.date, inSameDayAs: date) {
                counts[entry.meal.size, default: 0] += 1
            }
        }
        
        return counts
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Date bar
                    HStack {
                        Button {
                            self.date = self.date.addingTimeInterval(-ONE_DAY)
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        
                        Spacer()
                        
                        Button {
                            self.isShowingDatePicker = true
                        } label: {
                            Text(dateLabel)
                                .font(.headline)
                        }
                        
                        Spacer()
                        
                        Button {
                            self.date = self.date.addingTimeInterval(ONE_DAY)
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Summary
                    HStack {
                        ForEach(Size.allCases, id: \.self) { size in
                            if mealCountBySize[size] ?? 0 > 0 {
                                size.tag(count: mealCountBySize[size]!)
                            }
                        }
                    }.padding()
                    
                    // Entries
                    List {
                        ForEach(currentDayEntries) { entry in
                            ZStack {
                                NavigationLink(destination: AddEntryView(entry: entry).navigationBarTitle("Edit entry", displayMode: .inline)) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(entry.meal.title)
                                            .bold()
                                        Text(formatDate(entry.date))
                                            .foregroundColor(.gray)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    Text(entry.meal.size.rawValue)
                                        .foregroundColor(entry.meal.size.color)
                                    
                                }
                            }
                        }
                        .onDelete(perform: deleteEntries)
                    }
                    .listStyle(.plain)
                }
                
                // Add button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            isShowingAddEntryView.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        .padding(20)
                    }
                }
                
                if isShowingDatePicker {
                    ZStack {
                        Color(.systemBackground)
                            .opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.isShowingDatePicker = false
                            }
                        
                        VStack {
                            DatePicker("", selection: $date, displayedComponents: [.date])
                                .onChange(of: date) {
                                    self.isShowingDatePicker = false
                                }
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .labelsHidden()
                                .padding()
                            
                            Button("Go to today") {
                                self.date = Date()
                                self.isShowingDatePicker = false
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 500)
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddEntryView) {
                NavigationView {
                    AddEntryView().navigationBarTitle("Add entry", displayMode: .inline)
                }
            }
        }
    }
    
    var dateLabel: String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
    
    
    var currentDayEntries: [Entry] {
        return entries.filter { entry in
            Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
    }
    
    
    func deleteEntries(_ indexSet: IndexSet) {
        for index in indexSet {
            let entry = entries[index]
            modelContext.delete(entry)
        }
    }
}

#Preview {
    TodayView()
}
