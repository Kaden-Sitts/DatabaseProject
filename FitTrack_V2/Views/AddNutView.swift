//
//  AddNutView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import SwiftUI

struct AddNutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var nutData = nutInfo()
    @State private var calories_s = ""
    @State private var protein_s = ""
    @State private var selectedDate = Date()
    let userID: Int64
    
    var body: some View {

        VStack{
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
            
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
            
            InputView(text: $nutData.mealType,
                      title: "Meal Type",
                      placeholder: "Lunch, Dinner, Snack, etc.")
            .autocapitalization(.none)
            
            // convert to int
            InputView(text: $calories_s,
                      title: "Calories",
                      placeholder: "Enter amount of calories")
            .autocapitalization(.none)
            
            InputView(text: $protein_s,
                      title: "Protein",
                      placeholder: "Enter amount of protein")
            .autocapitalization(.none)
        }
        .padding()
        // only add button, back should be in top
        Button{
            // Convert calories and protein
            if let calories = Double(calories_s), let protein = Double(protein_s) {
                // Format the selected date
                let dateString = dateFormatter.string(from: selectedDate)
                
                // Set the formatted date string and other values to nutData
                nutData.dateNutrition = dateString
                nutData.calories = Int(calories)
                nutData.protein = Int(protein)
                nutData.userIDNutritionFK = Int(userID)

                if addNut(nutData: nutData){
                    // added successfully
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    // did not add
                    
                }
                
            } else {
                // Handle invalid input
                print("Invalid input")
            }
        }
        label:{
            Text("Save")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
        }
    }
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

#Preview {
    AddNutView(userID: Int64(5))
}
