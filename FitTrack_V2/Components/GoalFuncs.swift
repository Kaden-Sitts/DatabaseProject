//
//  GoalFuncs.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/30/24.
//

import Foundation
import SwiftUI
import SQLite

func addGoal(goalData: goalInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let goals = Table("Goals")
        let userIDGoalFK = Expression<Int64>("UserID")
        let goalType = Expression<String>("GoalType")
        let targetWeight = Expression<Double>("TargetWeight")
        let targetDate = Expression<String>("TargetDate")
        let currentWeight = Expression<Double>("CurrentWeight")
        let currentDate = Expression<String>("CurrentDate")
        let initialWeight = Expression<Double>("InitialWeight") // New column

        try db.run(goals.insert(userIDGoalFK <- Int64(goalData.userIDGoalFK),
                                goalType <- goalData.goalType,
                                targetWeight <- Double(goalData.targetWeight),
                                targetDate <- goalData.targetDate,
                                currentWeight <- Double(goalData.currentWeight),
                                currentDate <- goalData.currentDate,
                                initialWeight <- Double(goalData.currentWeight)))
        // entry added to goals table
        return true

    } catch {
        // Error adding to goals table
        print("Error adding to goals table: \(error)")
        return false
    }
}

// made this to fix goals table
func recreateGoalsTable() {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let goals = Table("Goals")
        let users = Table("Users")
        let userID = Expression<Int64>("UserID")
        let goalID = Expression<Int64>("GoalID")
        let userIDGoalFK = Expression<Int64>("UserID")
        let goalType = Expression<String>("GoalType")
        let targetWeight = Expression<Double>("TargetWeight")
        let targetDate = Expression<String>("TargetDate")
        let currentWeight = Expression<Double>("CurrentWeight")
        let currentDate = Expression<String>("CurrentDate")
        let initialWeight = Expression<Double>("InitialWeight") // New column

        // Drop the table if it exists
        try db.run(goals.drop(ifExists: true))

        // Recreate the table
        try db.run(goals.create { t in
            t.column(goalID, primaryKey: true)
            t.column(userIDGoalFK)
            t.column(goalType)
            t.column(targetWeight)
            t.column(targetDate)
            t.column(currentWeight)
            t.column(currentDate)
            t.column(initialWeight) // Add initial weight column
            t.foreignKey(userIDGoalFK, references: users, userID)
        })

        print("Goals table dropped and recreated successfully")
    } catch {
        // Error dropping or recreating the table
        print("Error dropping or recreating the Goals table: \(error)")
    }
}

func getGoals(forUserID userID: Int64) -> [goalInfo] {
    let databaseURL = getDatabaseURL()
    
    var goalsList = [goalInfo]()
    do {
        let db = try Connection(databaseURL.path)
        let goals = Table("Goals")
        let goalID = Expression<Int64>("GoalID")
        let userIDGoalFK = Expression<Int64>("UserID")
        let goalType = Expression<String>("GoalType")
        let targetWeight = Expression<Double>("TargetWeight")
        let targetDate = Expression<String>("TargetDate")
        let currentWeight = Expression<Double>("CurrentWeight")
        let currentDate = Expression<String>("CurrentDate")
        let initialWeight = Expression<Double>("InitialWeight") // New column
        
        let query = goals.filter(userIDGoalFK == userID)
        
        do {
            for entry in try db.prepare(query) {
                let goalID = entry[goalID]
                let goalType = entry[goalType]
                let targetWeight = entry[targetWeight]
                let targetDate = entry[targetDate]
                let currentWeight = entry[currentWeight]
                let currentDate = entry[currentDate]
                let initialWeight = entry[initialWeight]
                let goalEntry = goalInfo(goalID: Int(goalID),
                                         userIDGoalFK: Int(userID),
                                         targetWeight: targetWeight,
                                         targetDate: targetDate,
                                         initialWeight: initialWeight,
                                         currentWeight: currentWeight,
                                         currentDate: currentDate,
                                         goalType: goalType)
                goalsList.append(goalEntry)
            }
        } catch {
            print("Error fetching goal entries: \(error)")
        }
    } catch {
        print("Error fetching goal entries: \(error)")
    }
    return goalsList
}

func deleteGoal(goalID: Int64) -> Bool {
    let databaseURL = getDatabaseURL()
    
    do {
        let db = try Connection(databaseURL.path)
        let goals = Table("Goals")
        let savedgoalID = Expression<Int64>("GoalID")
        let query = goals.filter(goalID == savedgoalID)
        
        if let _ = try db.pluck(query) {
            try db.run(query.delete())
            return true
        } else {
            print("goal not found \(goalID)")
            return false
        }
    } catch {
        print("error in deleting goal \(error)")
        return false
    }
}

/*
 func deleteWorkoutEntry(workoutID: Int64) -> Bool {
     let databaseURL = getDatabaseURL()
     
     do {
         let db = try Connection(databaseURL.path)
         let workoutLog = Table("WorkoutLog")
         let savedworkoutID = Expression<Int64>("WorkoutID")
         let query = workoutLog.filter(workoutID == savedworkoutID)
         
         if let _ = try db.pluck(query) {
             try db.run(query.delete())
             return true
         } else {
             print("Workout not found \(workoutID)")
             return false
         }
     } catch {
         print("Error deleting workout entry: \(error)")
         return false
     }
 }
 */
