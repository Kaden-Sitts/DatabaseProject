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

func updateExer(exerData: exerInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        let exerID = Expression<Int64>("ExerciseID")
        let name = Expression<String>("Name")
        let muscleGroup = Expression<String>("MuscleGroup")

        // Check if exercise with exerID exists
        let query = exercises.filter(exerID == Int64(exerData.exerciseID))
        
        let update = query.update([
            name <- exerData.name,
            muscleGroup <- exerData.muscleGroup
        ])
        
        try db.run(update)
        // Exercise updated successfully
        return true
       

    } catch {
        // Error updating exercise
        print("Error updating exercise: \(error)")
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

func getAllExer() -> [exerInfo] {
    var exercisesList = [exerInfo]()
    
    do {
        let databaseURL = getDatabaseURL()
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        let savedExerID = Expression<Int64>("ExerciseID")
        let savedName = Expression<String>("Name")
        let muscleGroup = Expression<String>("MuscleGroup")

        for exercise in try db.prepare(exercises) {
            let exerID = exercise[savedExerID]
            let name = exercise[savedName]
            let muscleGroupValue = exercise[muscleGroup]
            let exerInfoObject = exerInfo(exerciseID: Int(exerID), name: name, muscleGroup: muscleGroupValue)
            exercisesList.append(exerInfoObject)
        }
    } catch {
        print("Error fetching exercises: \(error)")
    }
    
    return exercisesList
}

func getExerInfo(forExerID exerID: Int64) -> exerInfo? {
    var exerciseInfo: exerInfo?

    do {
        let databaseURL = getDatabaseURL()
        let db = try Connection(databaseURL.path)
        let exercises = Table("Exercises")
        let savedExerID = Expression<Int64>("ExerciseID")
        let savedName = Expression<String>("Name")
        let muscleGroup = Expression<String>("MuscleGroup")

        let query = exercises.filter(savedExerID == exerID)

        if let exercise = try db.pluck(query) {
            let name = exercise[savedName]
            let muscleGroupValue = exercise[muscleGroup]
            exerciseInfo = exerInfo(exerciseID: Int(exerID), name: name, muscleGroup: muscleGroupValue)
        }
    } catch {
        print("Error fetching exercise info for ID \(exerID): \(error)")
    }

    return exerciseInfo
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
