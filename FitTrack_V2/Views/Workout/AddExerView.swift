//
//  AddExerView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/29/24.
//

import SwiftUI

struct AddExerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var exerData = exerInfo()
    @State private var showAlert = false
    
    var body: some View {
        VStack() {
            InputView(text: $exerData.name,
                      title: "Exercise name",
                      placeholder: "Enter name of exercise")
            .autocapitalization(.none)
            
            InputView(text: $exerData.muscleGroup,
                      title: "Muscle Group",
                      placeholder: "Tricep, cardio, chest, etc.")
            .autocapitalization(.none)
        
            Button{
                // action to add exercise to table
                if addExer(exerData: exerData){
                    // added successfully
                    self.presentationMode.wrappedValue.dismiss()
                }
                else{
                    // did not add successfully, print alert
                    showAlert = true
                }
            }
            label: {
                Text("Add Exercise")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
                    Alert(title: Text("Exercise Already Exists"), message: Text("The exercise name already exists in the database or encountered an error."), dismissButton: .default(Text("OK")))
                }
        .padding()
    }
}

#Preview {
    AddExerView()
}
