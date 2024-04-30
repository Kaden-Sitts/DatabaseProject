//
//  NutFuncs.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import Foundation
import SQLite
import SwiftUI

func addNut(nutData: nutInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let nutrition = Table("Nutrition")
        //let nutritionID = Expression<Int64>("NutritionID")
        let userIDNutritionFK = Expression<Int64>("UserID")
        let dateNutrition = Expression<String>("Date")
        let mealType = Expression<String>("MealType")
        let calories = Expression<Double>("Calories")
        let protein = Expression<Double>("Protein")

        try db.run(nutrition.insert(userIDNutritionFK <- Int64(nutData.userIDNutritionFK),
                                    dateNutrition <- nutData.dateNutrition,
                                    mealType <- nutData.mealType,
                                    calories <- Double(nutData.calories),
                                    protein <- Double(nutData.protein)))
        // entry added to nutrition table
        return true

    } catch {
        // Error adding to nutrition table
        return false

    }
}

func getNutritionEntries(forUserID userID: Int64) -> [nutInfo] {
    let databaseURL = getDatabaseURL()
    
    var nutritionEntries = [nutInfo]()
    do {
        let db = try Connection(databaseURL.path)
        let nutrition = Table("Nutrition")
        let nutritionID = Expression<Int64>("NutritionID")
        let userIDNutritionFK = Expression<Int64>("UserID")
        let dateNutrition = Expression<String>("Date")
        let mealType = Expression<String>("MealType")
        let calories = Expression<Double>("Calories")
        let protein = Expression<Double>("Protein")
        
        let query = nutrition.filter(userIDNutritionFK == userID)
        
        do {
            for entry in try db.prepare(query) {
                let nutritionID = entry[nutritionID]
                let date = entry[dateNutrition]
                let mealType = entry[mealType]
                let calories = entry[calories]
                let protein = entry[protein]
                let nutritionEntry = nutInfo(nutritionID: Int(nutritionID),
                                             userIDNutritionFK: Int(userID),
                                             dateNutrition: date,
                                             mealType: mealType,
                                             calories: Int(calories),
                                             protein: Int(protein))
                nutritionEntries.append(nutritionEntry)
            }
        } catch {
            print("Error fetching nutrition entries: \(error)")
        }
    } catch {
        print("Error fetching nutrition entries: \(error)")
    }
    return nutritionEntries
}

func deleteNutEntry(nutID: Int64) -> Bool {
    let databaseURL = getDatabaseURL()
    
    do {
        let db = try Connection(databaseURL.path)
        let nutrition = Table("Nutrition")
        let nutritionID = Expression<Int64>("NutritionID") // Corrected column name
        let query = nutrition.filter(nutritionID == nutID) // Corrected filter expression
        
        if let _ = try db.pluck(query) {
            try db.run(query.delete())
            return true
        } else {
            print("Nutrition not found \(nutID)")
            return false
        }
    } catch {
        print("Error deleting nutrition entry: \(error)")
        return false
    }
}
