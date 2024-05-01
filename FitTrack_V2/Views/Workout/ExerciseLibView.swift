//
//  ExerciseLibView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/30/24.
//

import SwiftUI
import Combine

struct ExerciseLibView: View {
    @State private var exercises: [exerInfo] = []
    @State private var searchText: String = ""
    @State private var editMade = false

    var filteredExercises: [exerInfo] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText) ||
                    exercise.muscleGroup.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding(.horizontal)
            
            NavigationLink(destination: AddExerView()) {
                Text("Create New Exercise")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(5)
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(filteredExercises, id: \.exerciseID) { exercise in
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Name: \(exercise.name)")
                                Text("Muscle Group: \(exercise.muscleGroup)")
                                Divider()
                            }
                            .padding()
                            
                            Spacer()
                            
                            NavigationLink(destination: EditExerView(exerID: Int64(exercise.exerciseID), editMade: $editMade)) {
                                Text("Edit")
                                    .padding()
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            refreshExercises()
        }
        .onReceive(Just(editMade)) { _ in
            if editMade {
                refreshExercises()
                editMade = false // Reset editMade flag
            }
        }
    }

    func refreshExercises() {
        exercises = getAllExer()
    }
}





#Preview {
    ExerciseLibView()
}
