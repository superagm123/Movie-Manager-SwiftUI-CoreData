//
//  FloatingActionButton.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

struct FloatingActionButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        }label:{
            Image(systemName: "plus")
                .font(.system(size: 50))
        }
        .buttonStyle(.borderedProminent)
        .clipShape(Circle())
        .tint(.movieSecondary)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 75, trailing: 30))
    }
}

#Preview{
    FloatingActionButton{}
}
