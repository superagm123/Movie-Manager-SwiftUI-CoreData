//
//  MovieDetailsScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 27/11/24.
//

import SwiftUI

struct MovieDetailsScreen: View {
    
    @FetchRequest(sortDescriptors: []) private var actors: FetchedResults<Actor>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var movie: Movie
    
    @State private var name: String = ""
    @State private var director: String = ""
    @State private var year: Int?
    @State private var selectedGenres: Set<Genre> = []
    
    private var isFormValid: Bool {
        return !name.isEmptyOrWhitespace && !director.isEmptyOrWhitespace && year != nil && year! >= 0 && !selectedGenres.isEmpty
    }
    
    private func updateMovie(){
        movie.name = name.capitalized
        movie.director = director.capitalized
        movie.year = Int16(year!)
        movie.genres = NSSet(array: Array(selectedGenres))
        
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
    }
    
    init(movie: Movie){
        self.movie = movie
        _actors = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "ANY movies == %@", movie))
    }
    
    var body: some View {
        Form{
            Section("Director"){
                Text(movie.director ?? "")
                    .frame(maxWidth: .infinity)
            }
            Section("Cast"){
                List(actors){actor in
                    DisclosureGroup{
                        if let movies = actor.movies as? Set<Movie>{
                            Text(movies.map{$0.name ?? ""}, format: .list(type: .and))
                        }
                    }label: {
                        Label(actor.name ?? "", systemImage: "person.fill")
                    }
                    .foregroundStyle(.movieSecondary)
                    .font(.title2)
                }
            }
            Section("Update - \(movie.name ?? "")"){
                TextField("Name", text: $name)
                TextField("Director", text: $director)
                TextField("Year", value: $year, format: .number)
                    .keyboardType(.numberPad)
                GenreSelectionView(selectedGenres: $selectedGenres)
                RoundedButton("Update"){
                    updateMovie()
                }
                .disabled(!isFormValid)
            }
        }
        .navigationTitle(movie.name ?? "")
        .font(.title3)
        .onAppear{
            name = movie.name!
            director = movie.director!
            year = Int(movie.year)
            selectedGenres = movie.genres as? Set<Genre> ?? []
        }
    }
}

struct MovieDetailsScreenContainer: View {
    
    @FetchRequest(sortDescriptors: []) private var movies: FetchedResults<Movie>
    
    var body: some View {
        MovieDetailsScreen(movie: movies.first!)
    }
}

#Preview{
    NavigationStack{
        MovieDetailsScreenContainer()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}


