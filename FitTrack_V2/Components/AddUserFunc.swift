//
//  SignUpFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SQLite
import SwiftUI

func addUser(username: String, password: String, message: inout String) {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        //let userID = Expression<Int64>("UserID")
        let savedUsername = Expression<String>("Username")
        let savedPassword = Expression<String>("Password")
        let savedEmail = Expression<String>("Email")
        let savedAge = Expression<Double>("Age")
        let savedGender = Expression<String>("Gender")
        let savedHeight = Expression<String>("Height")
        let savedWeight = Expression<Double>("Weight")
        let savedInitialWeight = Expression<Double>("InitialWeight")

        let query = users.filter(savedUsername == username)

        if let _ = try db.pluck(query) {
            // User already exists
            message = "User already exists"
        } else {
            try db.run(users.insert(savedUsername <- username,
                                     savedPassword <- password,
                                     savedEmail <- "",
                                     savedAge <- 0,
                                     savedGender <- "",
                                     savedHeight <- "",
                                     savedWeight <- 0,
                                     savedInitialWeight <- 0))
            // User signed up correctly
            message = "Successfully signed up!"
        }
    } catch {
        // Error in signing up
        message = "Error in signing up: \(error)"
    }
}
