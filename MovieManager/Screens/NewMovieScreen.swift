//
//  NewMovieScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

struct NewMovieScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var director: String = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []
    @State private var selectedGenres: Set<Genre> = []
    
    private var isFormValid: Bool {
        return !name.isEmptyOrWhitespace && !director.isEmptyOrWhitespace && year != nil && year! > 0 && !selectedActors.isEmpty
    }
    
    private func saveMovie(){
        let newMovie = Movie(context: viewContext)
        newMovie.name = name.capitalized
        newMovie.year = Int16(year!)
        newMovie.director = director.capitalized
        newMovie.actors = NSSet(array: Array(selectedActors))
        newMovie.genres = NSSet(array: Array(selectedGenres))
        
        do{
            try viewContext.save()
            dismiss()
        }catch{
            print(error)
        }
    }
    
    var body: some View{
        Form{
            TextField("Name", text: $name)
            TextField("Director", text: $director)
            TextField("Year", value: $year, format: .number)
                .keyboardType(.numberPad)
            Section("Genres"){
                GenreSelectionView(selectedGenres: $selectedGenres)
            }
            .listRowBackground(Color.clear)
            Section("Actors"){
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        .navigationTitle("New Movie")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    saveMovie()
                }
                .disabled(!isFormValid)
                .foregroundStyle(isFormValid ? .movieSecondary : .gray)
                .font(.title2)
            }
        }
        .presentationDetents([.medium])
        .font(.title3)
    }
}

#Preview{
    NavigationStack{
        NewMovieScreen()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
