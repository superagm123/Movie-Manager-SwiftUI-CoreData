//
//  CoreDataProvider.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    private let container: NSPersistentContainer
    
    static var preview: CoreDataProvider {
        let provider = CoreDataProvider(inMemory: true)
        let viewContext = provider.viewContext
        
        for index in 0...10{
            let newMovie = Movie(context: viewContext)
            newMovie.name = "Movie \(index)"
            newMovie.director = "\(index)"
            newMovie.year = Int16.random(in: 2000...2025)
            
            let newActor = Actor(context: viewContext)
            newActor.name = "Actor \(index)"
            
            newMovie.addToActors(newActor)
        }
        
        let commonGenres = ["Action", "Comedy", "Romance", "Fantasy", "Horror", "Drama", "Sci-fi", "Mystery", "Thriller", "Western", "War", "Animation", "Documentary"]
        
        for commonGenre in commonGenres {
            let newGenre = Genre(context: viewContext)
            newGenre.name = commonGenre
        }
               
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
        
        return provider
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "DataModel")
        
        if inMemory{
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores{_, error in
            if let error {
                print("Error loading persistent stores: \(error.localizedDescription)")
            }
        }
    }
    
}
