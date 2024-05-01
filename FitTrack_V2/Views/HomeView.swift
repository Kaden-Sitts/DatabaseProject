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
                HStack {
                    NavigationLink(destination: ProfileView(userID: userID)){
                        VStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 70))
                                .padding(.top, 10)
                                .padding(.bottom, 14)
                            
                            Text("View Profile")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(width: 140, height: 140)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(20)
                    }
                                                                
                    NavigationLink(destination: NutritionView(userID: userID)){
                        VStack{
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 70))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            
                            Text("Nutrition Log")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(width: 140, height: 140)
                        .padding()
                        .background(Color(red: 0.1, green: 0.4, blue: 0.4))
                        .cornerRadius(20)
                    }
                }


                HStack{
                    
                    NavigationLink(destination: WorkoutView(userID: userID)){
                        VStack{
                            Image(systemName: "list.clipboard.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 70))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            Text("Workout Log")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(width: 140, height: 140)
                        .padding()
                        .background(Color(red: 0.8, green: 0.4, blue: 0.4))
                        .cornerRadius(20)
                    }
                    
                    NavigationLink(destination: GoalsView(userID: userID)){
                        VStack{
                            Image(systemName: "target")
                                .foregroundColor(.white)
                                .font(.system(size: 85))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            Text("Goals")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(width: 140, height: 140)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                    }
                }
                
                NavigationLink(destination: ExerciseLibView()){
                    VStack{
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 70))
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        
                        Text("Exersise Library")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 140, height: 140)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(20)
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
