//
//  WorkoutView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/28/24.
//

import SwiftUI

struct WorkoutView: View {
    let userID: Int64
    @State private var workoutEntriesByDay: [String: [workInfo]] = [:]

    var body: some View {
        VStack{
            HStack{
                NavigationLink(destination: AddWorkView(userID: userID)){
                    Text("Add Entry")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(5)
                }
                
                NavigationLink(destination: HighScoreView(userID: userID)){
                    Text("High Scores")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 1, green: 0.8, blue: 0.2))
                        .cornerRadius(5)
                }
            }
            Spacer()
            
            ScrollView{
                ForEach(workoutEntriesByDay.keys.sorted(by: >), id: \.self) { day in
                    VStack(alignment: .leading) {
                        Text(day)
                            .font(.headline)
                            .padding(.top)

                        ForEach(workoutEntriesByDay[day] ?? [], id: \.workoutID) { entry in
                            HStack {
                                VStack(alignment: .leading) {
                                    if let exerciseName = getExerName(exerciseID: Int64(entry.exerciseFK)) {
                                        Text("Exercise: \(exerciseName)")
                                    } else {
                                        Text("Unknown Exercise")
                                    }
                                        Text("Volume: \(entry.volume)")
                                }

                                Spacer()

                                Button {
                                    // Delete action
//                                    if deleteWorkoutEntry(workoutID: entry.workoutID) {
//                                        // Delete was successful, update UI or handle as needed
//                                        let entries = getWorkoutEntries(forUserID: userID)
//                                        workoutEntriesByDay = Dictionary(grouping: entries, by: { $0.date })
//                                    } else {
//                                        // Delete failed, handle error
//                                    }
                                } label: {
                                    Text("Delete")
                                        .padding()
                                        .foregroundColor(.blue)
                                }
                            }
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(5)
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            let entries = getWorkoutEntries(forUserID: userID)
            workoutEntriesByDay = Dictionary(grouping: entries, by: { $0.date })
        }
    }
}

#Preview {
    WorkoutView(userID: Int64(5))
}


#Preview {
    WorkoutView(userID: Int64(5))
}
