//
//  DatabaseManager.swift
//  FitTrack
//
//  Created by Kaden Sitts on 4/2/24.
//

import Foundation
import SQLite

func setupDatabase() {
    let fileManager = FileManager.default
    let databaseFileName = "mydatabase.sqlite"
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let databaseURL = documentsURL.appendingPathComponent(databaseFileName)

    // If file does not exist
    if !fileManager.fileExists(atPath: databaseURL.path) {
        // Connect to database
        let db = try! Connection(databaseURL.path)

        // Define parts of our table for database
        let users = Table("users")
        let id = Expression<Int64>("id")
        let username = Expression<String>("username")
        let password = Expression<String>("password")

        // Create our table
        try! db.run(users.create { t in
            t.column(id, primaryKey: true)
            t.column(username, unique: true)
            t.column(password)
        })
    }
}
