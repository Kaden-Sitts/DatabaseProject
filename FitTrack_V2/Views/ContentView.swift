//
//  ContentView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @State private var username = ""
    
    var body: some View {
        // Navigation View to switch from LoginView
        // and HomeView
        NavigationView{
            if isLoggedIn {
                HomeView(username: username, isLoggedIn: $isLoggedIn)
            } else {
                    LoginView(username: $username, isLoggedIn: $isLoggedIn)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
