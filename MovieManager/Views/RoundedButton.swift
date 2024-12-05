//
//  RoundedButton.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 27/11/24.
//

import SwiftUI

struct RoundedButton: View {
    
    let text: String
    let action: () -> Void
    
    init(_ text: String, _ action: @escaping () -> Void){
        self.text = text
        self.action = action
    }
    
    var body: some View{
        Button{
            action()
        }label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .font(.title2)
        }
        .buttonStyle(.borderedProminent)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .foregroundStyle(.movieForeground)
        .tint(.movieSecondary)
        .padding()
    }
}

#Preview{
    RoundedButton("Rounded Button"){}
}
