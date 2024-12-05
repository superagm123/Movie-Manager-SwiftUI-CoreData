//
//  ActorCellView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 27/11/24.
//

import SwiftUI

struct ActorCellView: View {
    
    @ObservedObject var actor: Actor
    
    var body: some View {
        GroupBox{
            Text("Movies \(actor.movies?.count ?? 0)")
        }label:{
            Label(actor.name ?? "", systemImage: "person.fill")
        }
        .backgroundStyle(LinearGradient(colors: [.moviePrimary, .movieSecondary], startPoint: .bottomTrailing, endPoint: .topLeading))
        .foregroundStyle(.movieForeground)
        .font(.title3)
    }
}
