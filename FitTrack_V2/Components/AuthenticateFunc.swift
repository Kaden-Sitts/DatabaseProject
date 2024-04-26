//
//  AuthenticateFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SwiftUI
import SQLite


func authenticate (username: String, password: String, message: inout String, isLoggedIn: inout Bool) {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        let savedUsername = Expression<String>("Username")
        let savedPassword = Expression<String>("Password")

        let query = users.filter(savedUsername == username && savedPassword == password)

        if let _ = try db.pluck(query) {
            isLoggedIn = true
            // Message that log in should be successful
            message = "log in was successful"
        } else {
            isLoggedIn = false
            // Message that it didnt work
            message = "Incorrect Username or Password"
        }
    } catch {
        isLoggedIn = false
        // Message that error occured
        message = "Error with logging in"
    }
}

