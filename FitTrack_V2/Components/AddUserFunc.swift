//
//  SignUpFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SQLite
import SwiftUI

func addUser (username: String, password: String, message: inout String) {
    
    let fileManager = FileManager.default
    let databaseFileName = "mydatabase.sqlite"
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let databaseURL = documentsURL.appendingPathComponent(databaseFileName)

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("users")
        let savedUsername = Expression<String>("username")
        let savedPassword = Expression<String>("password")

        let query = users.filter(savedUsername == username)
            
        if let _ = try db.pluck(query)
        {
            // User already exists
            message = "User already exists"
        }
        else {
            try db.run(users.insert(savedUsername <- username, savedPassword <- password))
            // Message the user signed up correctly
            message = "Successfully signed up!"
        }

    } catch {
        // Error in signing up
        message = "Error in signing up"
    }
}
