//
//  File.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/26/24.
//

import Foundation
import SwiftUI

// Contains informatin for displaying a message with a color
struct Message {
    var text: String
    var color: Color
}

// Contains information relating to user data
struct userInfo {
    var userID = 0
    var username = ""
    var password = ""
    var email = ""
    var age = 0
    var Gender = ""
    var Height = ""
    var Weight = 0.0
    var InitialWeight = 0.0
}

struct nutInfo {
    var nutritionID = 0
    var userIDNutritionFK = 0
    var dateNutrition = ""
    var mealType = ""
    var calories = 0
    var protein = 0
}

struct workInfo {
    var workoutID = 0
    var userIDFK = 0
    var exerciseFK = 0
    var date = ""
    var volume = 0
}

struct exerInfo {
    var exerciseID = 0
    var name = ""
    var muscleGroup = ""
}
