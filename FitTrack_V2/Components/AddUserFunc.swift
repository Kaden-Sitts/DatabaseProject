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
                                    savedWeight <- userData.InitalWeight,
                                    savedInitialWeight <- userData.InitalWeight))
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
