//
//  AuthenticateFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SwiftUI
import SQLite

func authenticate(username: String, password: String, message: inout String, isLoggedIn: inout Bool) {
    guard let path = Bundle.main.path(forResource: "fit_track_db", ofType: "sqlite") else {
        message = "Database file not found"
        isLoggedIn = false
        return
    }

    do {
        let db = try Connection(path)
        let users = Table("Users")
        let savedUsername = Expression<String>("Username")
        let savedPassword = Expression<String>("Password")

        let query = users.filter(savedUsername == username && savedPassword == password)

        if let _ = try db.pluck(query) {
            isLoggedIn = true
            message = "Log in was successful"
        } else {
            isLoggedIn = false
            message = "Incorrect Username or Password"
        }
    } catch {
        isLoggedIn = false
        message = "Error with logging in: \(error)"
    }
}


