//
//  WorkoutFuncs.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/29/24.
//

import Foundation
import SwiftUI
import SQLite



func addExer(exerData: exerInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        //let exerciseID = Expression<Int64>("ExerciseID")
        let name = Expression<String>("Name")
        let muscleGroup = Expression<String>("MuscleGroup")

        // check if we already have the name of exercise in database
        let query = exercises.filter(name == exerData.name)

        if let _ = try db.pluck(query) {
            // exercise already exists
            // print alert for this
            return false

        } else {
            try db.run(exercises.insert(name <- exerData.name,
                                        muscleGroup <- exerData.muscleGroup))
            // entry added to nutrition table
            return true
        }

    } catch {
        // Error adding to exercise table
        return false

    }
}

func getExerID(name: String) -> Int64 {
    let databaseURL = getDatabaseURL()
    
    do{
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        let savedExerID = Expression<Int64>("ExerciseID")
        let savedName = Expression<String>("Name")

        let query = exercises.filter(savedName == name)
        
        if let exercise = try db.pluck(query) {
            let exerID = exercise[savedExerID]
            return exerID
        } else {
            print("Exercise not found")
            return 0
            
        }
    } catch {
        print("Error fetching exercise data: \(error)")
        return 0
    }
}

func getExerName(exerciseID: Int64) -> String? {
    let databaseURL = getDatabaseURL()
    
    do{
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        let savedExerID = Expression<Int64>("ExerciseID")
        let savedName = Expression<String>("Name")

        let query = exercises.filter(savedExerID == exerciseID)
        
        if let exercise = try db.pluck(query) {
            let exerName = exercise[savedName]
            return exerName
        } else {
            print("Exercise not found")
            return ("Exercise not found")
            
        }
    } catch {
        print("Error fetching exercise data: \(error)")
        return ("Error in exercise func")
    }
}

func addWork(workData: workInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let workoutLog = Table("WorkoutLog")
        //let workoutID = Expression<Int64>("WorkoutID")
        let userIDFK = Expression<Int64>("UserID")
        let exerciseFK = Expression<Int64>("ExerciseID")
        let date = Expression<String>("Date")
        let volume = Expression<Int>("Volume")

        try db.run(workoutLog.insert(userIDFK <- Int64(workData.userIDFK),
                                    exerciseFK <- Int64(workData.exerciseFK),
                                    date <- workData.date,
                                     volume <- workData.volume))
        // entry added to nutrition table
        return true

    } catch {
        // Error adding to nutrition table
        print("Error adding to workoutlog table")
        return false

    }
}

func getWorkoutEntries(forUserID userID: Int64) -> [workInfo] {
    let databaseURL = getDatabaseURL()
    
    var workoutEntries = [workInfo]()
    do {
        let db = try Connection(databaseURL.path)
        let workoutLog = Table("WorkoutLog")
        let workoutID = Expression<Int64>("WorkoutID")
        let userIDFK = Expression<Int64>("UserID")
        let exerciseFK = Expression<Int64>("ExerciseID")
        let date = Expression<String>("Date")
        let volume = Expression<Int>("Volume")
        
        let query = workoutLog.filter(userIDFK == userID)
        
        do {
            for entry in try db.prepare(query) {
                let workoutID = entry[workoutID]
                let date = entry[date]
                let exerciseFK = entry[exerciseFK]
                let volume = entry[volume]
                let workoutEntry = workInfo(workoutID: Int(workoutID),
                                             userIDFK: Int(userID),
                                            exerciseFK: Int(exerciseFK), 
                                            date: date,
                                            volume: volume)
                 workoutEntries.append(workoutEntry)
            }
        } catch {
            print("Error fetching nutrition entries: \(error)")
        }
    } catch {
        print("Error fetching nutrition entries: \(error)")
    }
    return workoutEntries
}
