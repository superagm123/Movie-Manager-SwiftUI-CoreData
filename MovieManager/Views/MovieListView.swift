//
//  MovieListView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

private enum SortDirections: CaseIterable, Identifiable{
    case asc
    case desc
    
    var id: SortDirections {
        return self
    }
    
    var name: String {
        switch self{
        case .asc:
            return "Ascending"
        case .desc:
            return "Descending"
        }
    }
}

struct MovieListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Movie.name, order: .forward)]) private var movies: FetchedResults<Movie>
    
    let  selectedFilter: FilterOptions
    
    private func deleteMovie(movie: Movie){
        viewContext.delete(movie)
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
    }
    
    init(selectedFilter: FilterOptions = .none){
        self.selectedFilter = selectedFilter
        switch selectedFilter{
        case .none:
            _movies = FetchRequest(sortDescriptors: [], predicate: NSPredicate(value: true))
        case .name(let name):
            _movies = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", name))
        case .director(let director):
            _movies = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "director BEGINSWITH %@", director))
        case .genres(let selectedGenres):
            _movies = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "ANY genres IN %@", selectedGenres))
        }
    }
    
    var body: some View {
        if movies.isEmpty{
            ContentUnavailableView("No movies yet.", systemImage:"list.clipboard")
        }else{
            List{
                ForEach(movies){movie in
                    NavigationLink{
                        MovieDetailsScreen(movie: movie)
                    }label:{
                        MovieCellView(movie: movie)
                    }
                }
                .onDelete{indexSet in
                    indexSet.forEach{index in
                        deleteMovie(movie: movies[index])
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview{
    MovieListView(selectedFilter: FilterOptions.none)
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
}
