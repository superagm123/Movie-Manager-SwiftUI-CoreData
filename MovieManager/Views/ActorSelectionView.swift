//
//  ActorSelectionView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 27/11/24.
//

import SwiftUI

struct ActorSelectionView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Actor.name, order: .forward)]) private var actors: FetchedResults<Actor>
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @Binding var selectedActors: Set<Actor>
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(actors){actor in
                    HStack(spacing: 25){
                        Text(actor.name ?? "")
                        Image(systemName: selectedActors.contains(actor) ? "checkmark.square" : "square")
                    }
                    .onTapGesture{
                        if selectedActors.contains(actor){
                            selectedActors.remove(actor)
                        }else{
                            selectedActors.insert(actor)
                        }
                    }
                }
            }
        }.scrollIndicators(.hidden)
    }
}

struct ActorSelectionViewContainer: View{
    
    @State private var selectedActors: Set<Actor> = []
    
    var body: some View {
        ActorSelectionView(selectedActors: $selectedActors)
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}

#Preview{
    ActorSelectionViewContainer()
}
