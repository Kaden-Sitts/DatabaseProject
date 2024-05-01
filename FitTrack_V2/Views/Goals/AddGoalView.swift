//
//  AddNutView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var goalData = goalInfo()
    @State private var weight_s = ""
    @State private var exerciseName = ""
    @State private var selectedDate = Date()
    @State private var add = false
    @State private var showAlert = false

    let userID: Int64
    
    var body: some View {
        VStack{
            //Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
            // Need the date, exercise, and volume
            Text("Select target date")
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
            
            InputView(text: $goalData.goalType,
                      title: "Goal Type",
                      placeholder: "Weight Loss, Weight Gain, etc.")
            .autocapitalization(.none)
            
            // convert to int
            InputView(text: $weight_s,
                      title: "Target Weight",
                      placeholder: "Weight you'd like to reach")
            .autocapitalization(.none)
        }
        .padding()
        // only add button, back should be in top
        
        Button{
            add = true
            if let targetWeight = Double(weight_s) {
                let dateString = dateFormatter.string(from: selectedDate)
                let currentDate = Date()
                let curDateString = dateFormatter.string(from: currentDate)
                goalData.targetWeight = targetWeight
                goalData.targetDate = dateString
                goalData.currentDate = curDateString
                goalData.userIDGoalFK = Int(userID)
                let curWeight = getUserWeight(userID: userID)
                goalData.currentWeight = curWeight
            } else {
                // volume could not be converted
                print("Target Weight could not be converted")
                add = false
            }
            
            
            if add {
                // all checks out, add to workout log
                if addGoal(goalData: goalData)
                {
                    // successfully added
                    self.presentationMode.wrappedValue.dismiss()
                    
                } else {
                    // error in adding to table
                }
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
    AddGoalView(userID: Int64(5))
}
