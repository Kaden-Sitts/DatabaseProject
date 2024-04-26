//
//  DatabaseManager.swift
//  FitTrack
//
//  Created by Kaden Sitts on 4/2/24.
//

import Foundation
import SQLite

func getDatabaseURL() -> URL {
    let fileManager = FileManager.default
    let databaseFileName = "mydatabase_V2.sqlite"
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let databaseURL = documentsURL.appendingPathComponent(databaseFileName)
    return databaseURL
}


func setupDatabase() {
    let fileManager = FileManager.default
    let databaseURL = getDatabaseURL()

    // If file does not exist
    if !fileManager.fileExists(atPath: databaseURL.path) {
        // Connect to database
        let db = try! Connection(databaseURL.path)

        // Define parts of the Users table
        let users = Table("Users")
        let userID = Expression<Int64>("UserID")
        let username = Expression<String>("Username")
        let password = Expression<String>("Password")
        let email = Expression<String>("Email")
        let age = Expression<Double>("Age")
        let gender = Expression<String>("Gender")
        let height = Expression<String>("Height")
        let weight = Expression<Double>("Weight")
        let initialWeight = Expression<Double>("InitialWeight")

        try! db.run(users.create { t in
            t.column(userID, primaryKey: true)
            t.column(username, unique: true)
            t.column(password)
            t.column(email)
            t.column(age)
            t.column(gender)
            t.column(height)
            t.column(weight)
            t.column(initialWeight)
        })

        // Define parts of the Exercises table
        let exercises = Table("Exercises")
        let exerciseID = Expression<Int64>("ExerciseID")
        let name = Expression<String>("Name")
        let muscleGroup = Expression<String>("MuscleGroup")

        try! db.run(exercises.create { t in
            t.column(exerciseID, primaryKey: true)
            t.column(name, unique: true)
            t.column(muscleGroup)
        })

        // Define parts of the WorkoutLog table
        let workoutLog = Table("WorkoutLog")
        let workoutID = Expression<Int64>("WorkoutID")
        let userIDFK = Expression<Int64>("UserID")
        let exerciseFK = Expression<Int64>("ExerciseID")
        let date = Expression<String>("Date")
        let volume = Expression<Int>("Volume")

        try! db.run(workoutLog.create { t in
            t.column(workoutID, primaryKey: true)
            t.column(userIDFK)
            t.column(exerciseFK)
            t.column(date)
            t.column(volume)
            t.foreignKey(userIDFK, references: users, userID)
            t.foreignKey(exerciseFK, references: exercises, exerciseID)
        })

        // Define parts of the Nutrition table
        let nutrition = Table("Nutrition")
        let nutritionID = Expression<Int64>("NutritionID")
        let userIDNutritionFK = Expression<Int64>("UserID")
        let dateNutrition = Expression<String>("Date")
        let mealType = Expression<String>("MealType")
        let calories = Expression<Double>("Calories")
        let protein = Expression<Double>("Protein")

        try! db.run(nutrition.create { t in
            t.column(nutritionID, primaryKey: true)
            t.column(userIDNutritionFK)
            t.column(dateNutrition)
            t.column(mealType)
            t.column(calories)
            t.column(protein)
            t.foreignKey(userIDNutritionFK, references: users, userID)
        })

        // Define parts of the Goals table
        let goals = Table("Goals")
        let goalID = Expression<Int64>("GoalID")
        let userIDGoalFK = Expression<Int64>("UserID")
        let goalType = Expression<String>("GoalType")
        let targetWeight = Expression<Double>("TargetWeight")
        let targetDate = Expression<String>("TargetDate")

        try! db.run(goals.create { t in
            t.column(goalID, primaryKey: true)
            t.column(userIDGoalFK)
            t.column(goalType)
            t.column(targetWeight)
            t.column(targetDate)
            t.foreignKey(userIDGoalFK, references: users, userID)
        })

        // Define parts of the Progress table
        let progress = Table("Progress")
        let progressID = Expression<Int64>("ProgressID")
        let goalIDProgressFK = Expression<Int64>("GoalID")
        //let weight = Expression<Double>("Weight")
        let bmi = Expression<Int>("BMI")

        try! db.run(progress.create { t in
            t.column(progressID, primaryKey: true)
            t.column(goalIDProgressFK)
            t.column(weight)
            t.column(bmi)
            t.foreignKey(goalIDProgressFK, references: goals, goalID)
        })
    }
}

func getUserData(username: String) -> (email: String, age: Double, gender: String, height: String, weight: Double, initialWeight: Double)? {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        let savedUsername = Expression<String>("Username")
        let savedEmail = Expression<String>("Email")
        let savedAge = Expression<Double>("Age")
        let savedGender = Expression<String>("Gender")
        let savedHeight = Expression<String>("Height")
        let savedWeight = Expression<Double>("Weight")
        let savedInitialWeight = Expression<Double>("InitialWeight")

        let query = users.filter(savedUsername == username)

        if let user = try db.pluck(query) {
            let email = user[savedEmail]
            let age = user[savedAge]
            let gender = user[savedGender]
            let height = user[savedHeight]
            let weight = user[savedWeight]
            let initialWeight = user[savedInitialWeight]
            return (email, age, gender, height, weight, initialWeight)
        } else {
            print("User not found")
            return nil
        }
    } catch {
        print("Error fetching user data: \(error)")
        return nil
    }
}
