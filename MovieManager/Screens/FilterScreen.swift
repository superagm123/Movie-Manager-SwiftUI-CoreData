//
//  FilterScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 28/11/24.
//

import SwiftUI

enum FilterOptions{
    case none
    case name(String)
    case director(String)
    case genres(Set<Genre>)
}

struct FilterScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var numberOfActors: Int?
    @State private var director: String = ""
    @State private var selectedGenres: Set<Genre> = []
    
    @Binding var selectedFilter: FilterOptions
    
    var body: some View {
        Form{
            Section("Filter by name"){
                TextField("Name", text: $name)
                RoundedButton("Filter"){
                    selectedFilter = .name(name)
                    dismiss()
                }.disabled(name.isEmptyOrWhitespace)
            }
            Section("Filter by director"){
                TextField("Director", text: $director)
                RoundedButton("Filter"){
                    selectedFilter = .director(director)
                    dismiss()
                }.disabled(director.isEmptyOrWhitespace)
            }
            Section("Filter by genres"){
                GenreSelectionView(selectedGenres: $selectedGenres)
                RoundedButton("Filter"){
                    selectedFilter = .genres(selectedGenres)
                    dismiss()
                }.disabled(selectedGenres.isEmpty)
            }
            
            RoundedButton("Show all movies"){
                selectedFilter = .none
                dismiss()
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Filter")
        .font(.title3)
    }
}

struct FilterScreenContainer: View {
    
    @State private var selectedFilter: FilterOptions = .none
    
    var body: some View {
        FilterScreen(selectedFilter: $selectedFilter)
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}

#Preview {
    NavigationStack{
        FilterScreenContainer()
    }
}
