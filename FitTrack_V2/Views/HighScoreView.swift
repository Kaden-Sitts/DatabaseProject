//
//  HighScoreView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/29/24.
//

import SwiftUI

struct HighScoreView: View {
    let userID: Int64
    @State private var bestVolumes: [String: Int] = [:]

    var body: some View {
        VStack{
            Text("Best sets for each exercise")
            List {
                ForEach(bestVolumes.sorted(by: { $0.value > $1.value }), id: \.key) { exerciseName, volume in
                    HStack {
                        Text("\(exerciseName): \(volume)")
                        Spacer()
                    }
                    .padding()
                }
            }
            .onAppear {
                let workoutEntries = getWorkoutEntries(forUserID: userID)
                let groupedEntries = Dictionary(grouping: workoutEntries, by: { $0.exerciseFK })
                
                var calculatedVolumes: [String: Int] = [:]
                for (exerciseID, entries) in groupedEntries {
                    let bestVolume = entries.map { $0.volume }.max() ?? 0
                    if let exerciseName = getExerName(exerciseID: Int64(exerciseID)) {
                        calculatedVolumes[exerciseName] = bestVolume
                    }
                }
                
                bestVolumes = calculatedVolumes
            }
        }
    }
}


#Preview {
    HighScoreView(userID: Int64(5))
}
