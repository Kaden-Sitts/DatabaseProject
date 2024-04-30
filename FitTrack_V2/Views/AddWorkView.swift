//
//  AddNutView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import SwiftUI

struct AddWorkView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var workData = workInfo()
    @State private var volume_s = ""
    @State private var exerciseName = ""
    @State private var selectedDate = Date()
    @State private var add = false
    @State private var showAlert = false

    let userID: Int64
    
    var body: some View {

        VStack{
            //Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
            // Need the date, exercise, and volume
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
            
            InputView(text: $exerciseName,
                      title: "Exercise",
                      placeholder: "Exercise performed")
            .autocapitalization(.none)
            
            // convert to int
            InputView(text: $volume_s,
                      title: "Volume",
                      placeholder: "reps * weight or minutes spent")
            .autocapitalization(.none)
        }
        .padding()
        // only add button, back should be in top
        
        Button{
            add = true
            let exerciseFK = getExerID(name: exerciseName)
            if exerciseFK != 0 {
                if let volume = Int(volume_s) {
                    let dateString = dateFormatter.string(from: selectedDate)
                    
                    workData.volume = volume
                    workData.exerciseFK = Int(exerciseFK)
                    workData.userIDFK = Int(userID)
                    workData.date = dateString
                    
                } else {
                    // volume could not be converted
                    print("Volume could not be converted")
                    add = false
                }
            } else {
                //
                print("Exercise does not exist")
                add = false
                showAlert = true
            }
            
            if add {
                // all checks out, add to workout log
                if addWork(workData: workData)
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
        
        Spacer()
        
        NavigationLink (destination: AddExerView()){
            Text("Create New Exercise")
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(5)
        }
        .alert(isPresented: $showAlert) {
                        Alert(title: Text("Exercise Does Not Exist"), message: Text("The excersise provided does not exist, consider adding it!"), dismissButton: .default(Text("OK")))
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
    AddWorkView(userID: Int64(5))
}
