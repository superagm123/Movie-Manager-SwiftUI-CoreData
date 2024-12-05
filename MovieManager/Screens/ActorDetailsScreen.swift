//
//  ActorDetailsScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 28/11/24.
//

import SwiftUI

struct ActorDetailsScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var actor: Actor
    
    @State private var name: String = ""
    @State private var selectedMovies: Set<Movie> = []
    
    private func updateActor(){
        actor.name = name.capitalized
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
    }
    
    var body: some View{
        Form{
            TextField("Name", text: $name)
            RoundedButton("Update"){
                updateActor()
            }.disabled(name.isEmptyOrWhitespace)
            Section("Movies"){
                MovieSelectionView(selectedMovies: $selectedMovies)
            }
        }
        .onAppear{
            name = actor.name ?? ""
            selectedMovies = actor.movies as? Set<Movie> ?? []
        }
        .onChange(of: selectedMovies){
            actor.movies = NSSet(array: Array(selectedMovies))
            do{
                try viewContext.save()
            }catch{
                print(error)
            }
        }
        .navigationTitle(actor.name ?? "")
        .font(.title3)
    }
}

struct ActorDetailsScreenContainer: View {
    
    @FetchRequest(sortDescriptors: []) private var actors: FetchedResults<Actor>
    
    var body: some View {
        ActorDetailsScreen(actor: actors.first!)
    }
}

#Preview{
    NavigationStack{
        ActorDetailsScreenContainer()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
