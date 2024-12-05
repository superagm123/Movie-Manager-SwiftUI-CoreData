//
//  MainScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

private enum Tabs: String, Hashable{
    case movies = "Movies"
    case actors = "Actors"
}

private enum Sheets: Identifiable {
    case newMovie
    case newActor
    case filter
    
    var id: Int {
        hashValue
    }
}

struct MainScreen: View{
    
    @State private var selectedTab: Tabs = .movies
    @State private var selectedSheet: Sheets?
    @State private var selectedFilter: FilterOptions = .none
    
    var body: some View {
        TabView(selection: $selectedTab){
            Tab("Movies", systemImage:"movieclapper.fill", value: .movies){
                MovieListView(selectedFilter: selectedFilter)
            }
            Tab("Actors", systemImage:"person.3.fill", value: .actors){
                ActorListView()
            }
        }
        .navigationTitle(selectedTab.rawValue)
        .sheet(item: $selectedSheet){selectedSheet in
            switch selectedSheet{
            case .newMovie:
                NavigationStack{
                    NewMovieScreen()
                }
            case .newActor:
                NavigationStack{
                    NewActorScreen()
                }
            case .filter:
                NavigationStack{
                    FilterScreen(selectedFilter: $selectedFilter)
                }
            }
        }
        .overlay(alignment: .bottomTrailing){
            FloatingActionButton{
                if selectedTab == .movies{
                    selectedSheet = .newMovie
                }else{
                    selectedSheet = .newActor
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Menu{
                    Button("Filter"){
                        selectedSheet = .filter
                    }
                }label:{
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.movieSecondary)
                        .font(.title2)
                }
            }
        }
        .tint(.movieSecondary)
    }
}

#Preview{
    NavigationStack{
        MainScreen()
    }
    .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
}
