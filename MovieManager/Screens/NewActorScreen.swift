//
//  NewActorScreen.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

struct NewActorScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    
    private func saveActor(){
        let newActor = Actor(context: viewContext)
        newActor.name = name.capitalized
        do{
            try viewContext.save()
            dismiss()
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        Form{
            TextField("Name", text: $name)
        }
        .navigationTitle("New Actor")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    saveActor()
                }
                .disabled(name.isEmptyOrWhitespace)
                .foregroundStyle(name.isEmptyOrWhitespace ? .gray : .movieSecondary)
                .font(.title2)
            }
        }
        .presentationDetents([.fraction(0.25)])
    }
}

#Preview{
    NavigationStack{
        NewActorScreen()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
