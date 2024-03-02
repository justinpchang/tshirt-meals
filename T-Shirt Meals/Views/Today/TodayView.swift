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
                    
                    List {
                        ForEach(currentDayEntries) { entry in
                            ZStack {
                                NavigationLink(destination: Text("\(entry.meal.title)")) {
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
                                        .foregroundColor(.blue)
                                    
                                }
                            }
                        }
                        .onDelete(perform: deleteEntries)
                    }
                    .listStyle(.plain)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingAddEntryView.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddEntryView) {
                    AddEntryView(isPresented: $isShowingAddEntryView)
                }
                
                if isShowingDatePicker {
                    ZStack {
                        Color(.darkGray)
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
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
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
