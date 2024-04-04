//
//  LoginView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var username: String
    @State private var password = ""
    @State private var message = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                // Put some logo here later
                
                Spacer()
                // form fields
                VStack(spacing: 20){
                    InputView(text: $username,
                              title: "Username",
                              placeholder: "Enter your username")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding()
                
                HStack{
                    
                    
                    Button{
                        // Add user to database
                        addUser(username: username, password: password, message: &message)
                    }
                    label: {
                        Text("Sign Up")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(5)
                    }
                    .padding()
                    
                    Button{
                        // Authenticate User to database
                        authenticate(username: username, password: password, message: &message, isLoggedIn: &isLoggedIn)
                    }
                    label: {
                        Text("Login")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    
                    .padding()
                }
                Text(message)
                    .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State private static var isLoggedIn = false
    @State private static var username = ""
    
    static var previews: some View {
        LoginView(username: $username, isLoggedIn: $isLoggedIn)
    }
}

