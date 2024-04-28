//
//  SignUpFunc.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import Foundation
import SQLite
import SwiftUI

func addUser(userData: userInfo, message: inout Message) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        //let userID = Expression<Int64>("UserID")
        let savedUsername = Expression<String>("Username")
        let savedPassword = Expression<String>("Password")
        let savedEmail = Expression<String>("Email")
        let savedAge = Expression<Int>("Age")
        let savedGender = Expression<String>("Gender")
        let savedHeight = Expression<String>("Height")
        let savedWeight = Expression<Double>("Weight")
        let savedInitialWeight = Expression<Double>("InitialWeight")

        let query = users.filter(savedUsername == userData.username)

        if let _ = try db.pluck(query) {
            // User already exists
            message = Message(text: "User already exists", color: .red)
            return false

        } else {
            try db.run(users.insert(savedUsername <- userData.username,
                                    savedPassword <- userData.password,
                                    savedEmail <- userData.email,
                                    savedAge <- userData.age,
                                    savedGender <- userData.Gender,
                                    savedHeight <- userData.Height,
                                    savedWeight <- userData.InitialWeight,
                                    savedInitialWeight <- userData.InitialWeight))
            // User signed up correctly
            message = Message(text: "Successfully signed up!", color: .green)
            return true

        }
    } catch {
        // Error in signing up
        message = Message(text: "Error in signing up: \(error)", color: .red)
        return false

    }
}

// Update user data in users table, check new and old vals, set and update
// accordingly. return true if updated, false if not updated due to error
func updateUser(userData: userInfo) -> Bool {
    let databaseURL = getDatabaseURL()

    do {
        // Define table
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        let savedUserID = Expression<Int64>("UserID")
        let savedUsername = Expression<String>("Username")
        let savedEmail = Expression<String>("Email")
        let savedAge = Expression<Int>("Age")
        let savedGender = Expression<String>("Gender")
        let savedHeight = Expression<String>("Height")
        let savedWeight = Expression<Double>("Weight")
        let savedInitialWeight = Expression<Double>("InitialWeight")
        
        let userToUpdate = users.filter(savedUserID == Int64(userData.userID))
        
        let update = userToUpdate.update([
            savedUsername <- userData.username,
            savedEmail <- userData.email,
            savedAge <- userData.age,
            savedGender <- userData.Gender,
            savedHeight <- userData.Height,
            savedWeight <- userData.Weight,
            savedInitialWeight <- userData.InitialWeight
        ])

        // Execute the update query
        try db.run(update)
        
        return true
    } catch {
        // Error in update
        // if statement for each to check if diff from old
        return false
    }
}

func getUserID(username: String) -> Int64 {
    let databaseURL = getDatabaseURL()
    
    do{
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        let saveduserID = Expression<Int64>("UserID")
        let savedUsername = Expression<String>("Username")
        
        let query = users.filter(savedUsername == username)
        
        if let user = try db.pluck(query) {
            let userID = user[saveduserID]
            return userID
        } else {
            print("User not found")
            return 0
            
        }
    } catch {
        print("Error fetching user data: \(error)")
        return 0
    }
}


func getUserData(userID: Int64) -> (userInfo)? {
    let databaseURL = getDatabaseURL()

    do {
        let db = try Connection(databaseURL.path)
        let users = Table("Users")
        let saveduserID = Expression<Int64>("UserID")
        let savedUsername = Expression<String>("Username")
        let savedEmail = Expression<String>("Email")
        let savedAge = Expression<Double>("Age")
        let savedGender = Expression<String>("Gender")
        let savedHeight = Expression<String>("Height")
        let savedWeight = Expression<Double>("Weight")
        let savedInitialWeight = Expression<Double>("InitialWeight")

        let query = users.filter(saveduserID == userID)

        if let user = try db.pluck(query) {
            let userID = user[saveduserID]
            let username = user[savedUsername]
            let email = user[savedEmail]
            let age = user[savedAge]
            let gender = user[savedGender]
            let height = user[savedHeight]
            let weight = user[savedWeight]
            let initialWeight = user[savedInitialWeight]
            return userInfo(userID: Int(userID), username: username, email: email, age: Int(age), Gender: gender, Height: height, Weight: weight, InitialWeight: initialWeight)
        } else {
            print("User not found")
            return nil
        }
        
    } catch {
        print("Error fetching user data: \(error)")
        return nil
    }
}
