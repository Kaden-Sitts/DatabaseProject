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
    @State private var message: Message = Message(text: "", color: .black)
    @Binding var isLoggedIn: Bool
    @State private var isSignUpActive = false // Track whether sign up view is active

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
                    
                    NavigationLink(destination: SignUpView(message: $message)){
                        Text("Sign Up")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(5)
                    }
                    
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
                Text(message.text)
                    .foregroundColor(message.color)
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

