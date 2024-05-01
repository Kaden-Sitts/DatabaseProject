//
//  GoalsView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/28/24.
//

import SwiftUI

struct GoalsView: View {
    let userID: Int64
    @State private var goalsEntries: [goalInfo] = []

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()

    var body: some View {
        VStack {
            NavigationLink(destination: AddGoalView(userID: userID)){
                Text("Create New Goal")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
            }
            Spacer()

            ScrollView{
                VStack(alignment: .leading) {
                    Text("Current Goals: ")
                        .bold()
                        .padding()
                    // Current goals have option to delete
                    ForEach(currentGoals, id: \.goalID) { goal in
                        GoalRowView(goal: goal, onDelete: {
                            // if deleted, update
                            if deleteGoal(goalID: Int64(goal.goalID)) {
                                let entries = getGoals(forUserID: userID)
                                goalsEntries = entries
                            } else {
                                print("Error deleting goal")
                            }
                        })
                    }
                    // Past goals have no option to delete
                    Text("Past Goals: ")
                        .bold()
                        .padding()
                    ForEach(pastGoals, id: \.goalID) { goal in
                        GoalRowView(goal: goal, onDelete: nil)
                    }
                }
            }
        }
        .onAppear {
            let entries = getGoals(forUserID: userID)
            goalsEntries = entries
        }
    }

    private var currentGoals: [goalInfo] {
        goalsEntries
            .sorted { goal1, goal2 in
                let remainingDays1 = Calendar.current.dateComponents([.day], from: Date(), to: goal1.tarDate ?? Date()).day ?? 0
                let remainingDays2 = Calendar.current.dateComponents([.day], from: Date(), to: goal2.tarDate ?? Date()).day ?? 0
                return remainingDays1 < remainingDays2
            }
            .filter { goal in
                let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: goal.tarDate ?? Date()).day ?? 0
                return remainingDays >= 0
            }
    }

    private var pastGoals: [goalInfo] {
        goalsEntries.filter { goal in
            let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: goal.tarDate ?? Date()).day ?? 0
            return remainingDays < 0
        }
    }
}

struct GoalRowView: View {
    let goal: goalInfo
    let onDelete: (() -> Void)?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: goal.tarDate ?? Date()).day ?? 0
                Text(remainingDays >= 0 ? "Remaining Days: \(remainingDays)" : "Finished \(abs(remainingDays)) days ago")
                    .foregroundColor(remainingDays >= 0 ? Color(red: 0.1, green: 0.5, blue: 0.1) : .red)

                Text("Goal Type: \(goal.goalType)")
                Text("Target Weight: \(String(format: "%.2f", goal.targetWeight))")
                Text("Target Date: \(goal.targetDate)")
                Text("Initial Weight: \(String(format: "%.2f", goal.initialWeight))")
            }

            Spacer()
            
            // Only displays
            if let onDelete = onDelete {
                Button(action: onDelete) {
                    Text("Delete")
                        .padding()
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(6)
        .padding(.vertical, 5)
    }
}


#Preview {
    GoalsView(userID: Int64(5))
}
