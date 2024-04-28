//
//  ProfileView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/27/24.
//

import SwiftUI

// view profile here and update profile if needed
struct ProfileView: View {
    @State private var userData: userInfo?
    @State private var newUserData = userInfo()
    @State private var isEdit = false
    let userID: Int64
    @State private var age_string = ""
    @State private var Iweight_string = ""
    @State private var update = false
    @State private var e_update = false
    var body: some View {
        VStack{
            
            Spacer()
            if !isEdit{
                // add an edit button somewhere here
                if let userData = userData {
                    List {
                        Text("Username: \(userData.username)")
                        Text("Email: \(userData.email)")
                        Text("Age: \(userData.age)")
                        Text("Gender: \(userData.Gender)")
                        Text("Height: \(userData.Height)")
                        Text("Weight: \(String(format: "%.2f", userData.Weight))")
                        Text("Initial Weight: \(String(format: "%.2f", userData.InitialWeight))")
                    }
                    .padding()
                    
                    Button{
                        isEdit = true
                        newUserData = userData
                    }
                label: {
                    Text("Edit Profile")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                } else {
                    // this is a lie, there is no loading, something went wrong, but don't let the user know ;)
                    Text("Loading...")
                        .padding()
                }
            } else {
                VStack{
                    InputView(text: $newUserData.username,
                              title: "Username",
                              placeholder: "\(newUserData.username)")
                    .autocapitalization(.none)
                    
                    InputView(text: $newUserData.email,
                              title: "Email",
                              placeholder: "\(newUserData.email)")
                    .autocapitalization(.none)
                    
                    InputView(text: $age_string,
                              title: "Age",
                              placeholder: "\(newUserData.age)")
                    .autocapitalization(.none)
                    
                    InputView(text: $newUserData.Gender,
                              title: "Gender",
                              placeholder: "\(newUserData.Gender)")
                    .autocapitalization(.none)
                    
                    InputView(text: $newUserData.Height,
                              title: "Height",
                              placeholder: "\(newUserData.Height)")
                    .autocapitalization(.none)
                    
                    InputView(text: $Iweight_string,
                              title: "Weight",
                              placeholder: "\(newUserData.Weight)")
                    .autocapitalization(.none)
                    
                        Spacer()
                        
                        HStack{
                            Button{
                                isEdit = false
                            }
                            label: {
                                Text("Cancel")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(5)
                            }
                            
                            Button{
                                // run update func
                                update = true
                                if !age_string.isEmpty{
                                    if let intValue = Int(age_string) {
                                        newUserData.age = intValue
                                    } else {
                                        // Handle invalid int
                                        update = false
                                        print("Invalid input")
                                    }
                                }
                                if !Iweight_string.isEmpty{
                                    if let dubValue = Double(Iweight_string){
                                        newUserData.Weight = dubValue
                                    } else {
                                        // Handle invalid double
                                        update = false
                                        print("Invalid double")
                                    }
                                }
                                if update {
                                    if updateUser(userData: newUserData)
                                    {
                                        userData = getUserData(userID: userID)
                                        e_update = false
                                        isEdit = false
                                    } else {
                                        e_update = true
                                    }
                                }
                            }
                            label: {
                                Text("Save Changes")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(5)
                            }
                            .alert(isPresented: $e_update) {
                                Alert(title: Text("Error in update"))
                            }
                        }
                }
                .padding()
            }
        }
        // appear on vstack render
        .onAppear {
            // Fetch user's data from the database
            userData = getUserData(userID: userID)
        }
        .navigationBarTitle("Profile")
    }
}

#Preview {
    ProfileView(userID: Int64(5))
}
