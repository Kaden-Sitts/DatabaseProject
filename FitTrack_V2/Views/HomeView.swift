//
//  HomeView.swift
//  FitTrack_V2
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI

struct HomeView: View {
    let username: String
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome home, \(username)!")
                    .padding()
                    .bold()
                    .foregroundColor(.green)
                    .padding()
                    .font(.system(size:70))
                
                Spacer()
                
                Button{
                    //action
                    isLoggedIn = false
                } label: {
                    Text("Logout")
                        .padding()
                        .cornerRadius(1)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(5)

                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isLoggedIn = true

        HomeView(username: "Test Demo", isLoggedIn: $isLoggedIn)
    }
}
