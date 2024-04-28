//
//  File.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/26/24.
//

import Foundation
import SwiftUI

// Contains informatin for displaying a message with a color
struct Message {
    var text: String
    var color: Color
}

// Contains information relating to user data
struct userInfo {
    var userID = 0
    var username = ""
    var password = ""
    var email = ""
    var age = 0
    var Gender = ""
    var Height = ""
    var Weight = 0.0
    var InitialWeight = 0.0
}
