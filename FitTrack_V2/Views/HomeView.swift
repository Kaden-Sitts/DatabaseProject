//
//  HomeView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI
//import SQLite

struct HomeView: View {
    //let username: String
    @Binding var isLoggedIn: Bool
    let userID: Int64

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: ProfileView(userID: userID)){
                    Text("View Profile")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(5)
                }
                
                NavigationLink(destination: NutritionView(userID: userID)){
                    Text("Nutrition Log")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 0.1, green: 0.4, blue: 0.4))
                        .cornerRadius(5)
                }
                
                NavigationLink(destination: WorkoutView(userID: userID)){
                    Text("Workout Log")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 0.8, green: 0.4, blue: 0.4))
                        .cornerRadius(5)
                }
                
                NavigationLink(destination: GoalsView()){
                    Text("Goals")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(5)
                }
                
                // Need to fix later
                NavigationLink(destination: GoalsView()){
                    Text("Exersise Library")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
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
            .navigationBarTitle("Home Screen")
        }
        .onAppear {
            // Call getUserID() to set userID
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isLoggedIn = true

        HomeView(isLoggedIn: $isLoggedIn, userID: Int64(5))
    }
}
