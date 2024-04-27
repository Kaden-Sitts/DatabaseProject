//
//  AuthenticateFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SwiftUI
import SQLite


func authenticate (username: String, password: String, message: inout Message, isLoggedIn: inout Bool) {
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
            message = Message(text:"log in was successful", color: .green)
        } else {
            isLoggedIn = false
            // Message that it didnt work
            message = Message(text:"Incorrect Username or Password", color: .red)
        }
    } catch {
        isLoggedIn = false
        // Message that error occured
        message = Message(text:"Error with logging in", color: .red)
    }
}

