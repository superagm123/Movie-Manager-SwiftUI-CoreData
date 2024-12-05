//
//  MovieCellView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

struct MovieCellView: View {
    
    @ObservedObject var movie: Movie
    
    @State private var animateGradient: Bool = false
    
    var body: some View {
        GroupBox{
            HStack(alignment: .firstTextBaseline){
                VStack(alignment: .leading){
                    Text("Director: \(movie.director ?? "")")
                    Text("Actors: \(movie.actors?.count ?? 0)")
                    HStack{
                        Text("Genres")
                        ScrollView(.horizontal){
                            if let genres = movie.genres as? Set<Genre>{
                                HStack{
                                    ForEach(Array(genres)){genre in
                                        Text(genre.name ?? "")
                                            .background(.movieSecondary)
                                            .foregroundStyle(.movieForeground)
                                    }
                                }
                            }
                        }.scrollIndicators(.hidden)
                    }
                }
                Spacer()
                Text(movie.year.description)
            }
        }label: {
            Label(movie.name ?? "", systemImage: "popcorn.fill")
                .font(.title2)
        }
        .backgroundStyle(LinearGradient(colors: [.moviePrimary, .movieSecondary], startPoint: .bottomTrailing, endPoint: .topLeading))
        .foregroundStyle(.movieForeground)
    }
}
