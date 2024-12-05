//
//  MovieSelectionView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 28/11/24.
//

import SwiftUI

struct MovieSelectionView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Movie.name, order: .forward)]) private var movies: FetchedResults<Movie>
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @Binding var selectedMovies: Set<Movie>
    
    var body: some View {
        if movies.isEmpty{
            ContentUnavailableView("No movies yet.", systemImage: "list.clipboard")
        }else{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(movies){movie in
                        HStack(spacing: 25){
                            Text(movie.name ?? "")
                            Image(systemName: selectedMovies.contains(movie) ? "checkmark.square" : "square")
                        }
                        .onTapGesture{
                            if selectedMovies.contains(movie){
                                selectedMovies.remove(movie)
                            }else{
                                selectedMovies.insert(movie)
                            }
                        }
                    }
                }
                .padding()
            }.scrollIndicators(.hidden)
        }
    }
}

struct MovieSelectionViewContainer: View {
    
    @State private var selectedMovies: Set<Movie> = []
    
    var body: some View{
        MovieSelectionView(selectedMovies: $selectedMovies)
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}

#Preview {
    MovieSelectionViewContainer()
}
