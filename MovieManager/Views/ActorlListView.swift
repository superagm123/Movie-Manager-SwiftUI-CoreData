//
//  ActorlListView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 27/11/24.
//

import SwiftUI

struct ActorListView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Actor.name, order: .forward)]) private var actors: FetchedResults<Actor>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private func deleteActor(actor: Actor){
        viewContext.delete(actor)
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        if actors.isEmpty{
            ContentUnavailableView("No actors yet.", systemImage: "list.clipboard")
        }else{
            List{
                ForEach(actors){actor in
                    NavigationLink{
                        ActorDetailsScreen(actor: actor)
                    }label: {
                        ActorCellView(actor: actor)
                    }
                }
                .onDelete{indexSet in
                    indexSet.forEach{index in
                        deleteActor(actor: actors[index])
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    ActorListView()
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
}
