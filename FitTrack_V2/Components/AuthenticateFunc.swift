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
    let fileManager = FileManager.default
    let databaseFileName = "mydatabase.sqlite"
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let databaseURL = documentsURL.appendingPathComponent(databaseFileName)

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("users")
        let savedUsername = Expression<String>("username")
        let savedPassword = Expression<String>("password")

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

