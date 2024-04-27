//
//  InputView.swift
//  FitTrack
//
//  Created by Kaden Sitts on 4/3/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.system(size:16))
            
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                
            } else {
                TextField(placeholder, text: $text)
            }
            
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Username", placeholder: "Username")
}
