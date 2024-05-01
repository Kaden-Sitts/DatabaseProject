//
//  NutritionView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import SwiftUI

struct NutritionView: View {
    let userID: Int64
    @State private var nutritionEntriesByDay: [String: [nutInfo]] = [:]

    var body: some View {
            VStack {
                NavigationLink(destination: AddNutView(userID: userID)){
                    Text("Add Entry")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(5)
                }
                Spacer()
                // Display list for each day
                ScrollView{
                    ForEach(nutritionEntriesByDay.keys.sorted(by: >), id: \.self) { day in
                        VStack(alignment: .leading) {
                            Text(day)
                                .font(.headline)
                                .padding(.top)
                            // Calculate daily total calories and proteins
                            let dailyEntries = nutritionEntriesByDay[day] ?? []
                            let totalCalories = dailyEntries.reduce(0) { $0 + $1.calories }
                            let totalProteins = dailyEntries.reduce(0) { $0 + $1.protein }
                            
                            // Display total calories and proteins
                            Text("Daily Calories: \(totalCalories)")
                            Text("Daily Proteins: \(totalProteins)")

                            ForEach(nutritionEntriesByDay[day] ?? [], id: \.nutritionID) { entry in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Meal: \(entry.mealType)")
                                        Text("Calories: \(entry.calories)")
                                        Text("Protein: \(entry.protein)")
                                        //Text("Id: \(entry.nutritionID)")
                                    }
                    
                                    
                                    Spacer()
                                    
                                    Button {
                                        // Delete action
                                        if deleteNutEntry(nutID: Int64(entry.nutritionID)) {
                                                        // Entry was deleted successfully, update UI or handle as needed
                                            let entries = getNutritionEntries(forUserID: userID)
                                                    // Group entries by date
                                                    nutritionEntriesByDay = Dictionary(grouping: entries, by: { $0.dateNutrition })
                                        } else {
                                                        // Entry could not be deleted, handle error
                                        }

                                        
                                    } label: {
                                        Text("Delete")
                                            .padding()
                                            .foregroundColor(.blue)
                                    }

                                }
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(5)
                            }
                        }
                        .padding()
                    }
                }
            }
        .onAppear {
            let entries = getNutritionEntries(forUserID: userID)
            // Group entries by date
            nutritionEntriesByDay = Dictionary(grouping: entries, by: { $0.dateNutrition })
        }
    }
}

#Preview {
    NutritionView(userID: Int64(5))
}
