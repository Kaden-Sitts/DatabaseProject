//
//  EditExerView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/30/24.
//

import SwiftUI

struct EditExerView: View {
    let exerID: Int64
    @Environment(\.presentationMode) var presentationMode

    @State private var exerData: exerInfo?
    @Binding var editMade: Bool
    @State private var newExerName = ""
    @State private var newMuscleGroup = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            if let exercise = exerData {
                
                InputView(text: $newExerName,
                          title: "New Name of Exercise",
                          placeholder: exercise.name)
                InputView(text: $newMuscleGroup,
                          title: "New Muscle Group",
                          placeholder: exercise.muscleGroup)
                
                Button("Save Changes") {
                    // Press to save
                    var updatedExerData = exercise
                    updatedExerData.name = newExerName
                    updatedExerData.muscleGroup = newMuscleGroup
                    if updateExer(exerData: updatedExerData) {
                        // dismiss and go back
                        editMade = true
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert = true
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Failed to update exercise"), dismissButton: .default(Text("OK")))
                }
            } else {
                Text("Loading exercise info...")
            }
        }
        .padding()
        .onAppear {
            exerData = getExerInfo(forExerID: exerID)
            newExerName = exerData?.name ?? ""
            newMuscleGroup = exerData?.muscleGroup ?? ""
        }
    }
}




#Preview {
    EditExerView(exerID: Int64(1), editMade: .constant(false))
}
