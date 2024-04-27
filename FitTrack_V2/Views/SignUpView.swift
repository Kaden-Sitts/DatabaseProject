//
//  SignUpView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/26/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var message: Message
    @State private var userData = userInfo()
    @State private var age_string = ""
    @State private var Iweight_string = ""
    @State private var intValue = 0
    @State private var dubValue = 0.0
    @State private var add = false
    @State private var user_added = false
    @State private var pass_check = ""
    
    
    var body: some View {
        VStack() {
            InputView(text: $userData.username,
                      title: "Username",
                      placeholder: "Enter your username")
            .autocapitalization(.none)
            
            InputView(text: $userData.password,
                      title: "Password",
                      placeholder: "Enter your password",
                    isSecureField: true)
            .autocapitalization(.none)
            
            InputView(text: $pass_check,
                      title: "Confirm Password",
                      placeholder: "Confirm password",
                    isSecureField: true)
            .autocapitalization(.none)
            
            InputView(text: $userData.email,
                      title: "Email",
                      placeholder: "Enter your email")
            .autocapitalization(.none)
            
            // convert to int
            InputView(text: $age_string,
                      title: "Age",
                      placeholder: "Enter your Age")
            .autocapitalization(.none)
            
            InputView(text: $userData.Gender,
                      title: "Gender",
                      placeholder: "Enter your Gender")
            .autocapitalization(.none)
            
            InputView(text: $userData.Height,
                      title: "Height",
                      placeholder: "Enter your Height")
            .autocapitalization(.none)
            
            InputView(text: $Iweight_string,
                      title: "Inital Weight",
                      placeholder: "Enter your initial weight")
            .autocapitalization(.none)
        
            Button{
                // convert numbers first
                if let intValue = Int(age_string) {
                    userData.age = intValue
                } else {
                    // Handle invalid int
                    add = false
                    print("Invalid input")
                }
                if let dubValue = Double(Iweight_string){
                    userData.InitalWeight = dubValue
                } else {
                    // Handle invalid double
                    add = false
                    print("Invalid double")
                }
                
                // Check passwords match
//                if pass_check != userData.password {
//                    //
//                    add = false
//                        //.alert
//                }
                
                
                if add {
                    if addUser(userData: userData, message: &message){
                        user_added = false
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        user_added = true
                    }
                }
            }
            label: {
                Text("Enroll")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
            }
            .padding()
            .alert(isPresented: $user_added) {
                Alert(title: Text(message.text))
            }
        }
        .padding()
    }
}
/*
 struct userInfo {
     var username = ""
     var password = ""
     var email = ""
     var age = 0
     var Gender = ""
     var Height = ""
     var Weight = 0
     var InitalWeight = 0
 }
 */
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let message = Binding<Message>(
            get: { Message(text: "", color: .black) },
            set: { _ in }
        )
        return SignUpView(message: message)
    }
}
