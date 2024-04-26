//
//  HomeView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI
//import SQLite

struct HomeView: View {
    let username: String
    @Binding var isLoggedIn: Bool
    
    @State private var userData: (email: String, age: Double, gender: String, height: String, weight: Double, initialWeight: Double)?
    
    var body: some View {
        NavigationView {
            VStack {
                if let userData = userData {
                    List {
                        Text("Username: \(username)")
                        Text("Email: \(userData.email)")
                        Text("Age: \(userData.age)")
                        Text("Gender: \(userData.gender)")
                        Text("Height: \(userData.height)")
                        Text("Weight: \(userData.weight)")
                        Text("Initial Weight: \(userData.initialWeight)")
                    }
                    .padding()
                } else {
                    Text("Loading...")
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    // Logout action
                    isLoggedIn = false
                }) {
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(5)
                }
            }
            .navigationBarTitle("Welcome home, \(username)!")
        }
        .onAppear {
            // Fetch user's data from the database
            userData = getUserData(username: username)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isLoggedIn = true

        HomeView(username: "Test Demo", isLoggedIn: $isLoggedIn)
    }
}
