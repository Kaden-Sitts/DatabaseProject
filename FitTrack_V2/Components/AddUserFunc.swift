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
    guard let path = Bundle.main.path(forResource: "fit_track_db", ofType: "sqlite") else {
        message = "Database file not found"
        return
    }

    do {
        let db = try Connection(path)
        let users = Table("Users")
        let savedUsername = Expression<String>("Username")
        let savedPassword = Expression<String>("Password")

        let query = users.filter(savedUsername == username)

        if let _ = try db.pluck(query) {
            // User already exists
            message = "User already exists"
        } else {
            try db.run(users.insert(savedUsername <- username, savedPassword <- password))
            // User signed up correctly
            message = "Successfully signed up!"
        }

    } catch {
        // Error in signing up
        message = "Error in signing up: \(error)"
    }
}

