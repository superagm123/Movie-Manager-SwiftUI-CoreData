//
//  GenreSeeder.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 28/11/24.
//

import Foundation
import CoreData

class GenreSeeder {
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext){
        self.viewContext = viewContext
    }
    
    func seed(_ commonGenres: [String]) throws {
        for commonGenre in commonGenres {
            let newGenre = Genre(context: viewContext)
            newGenre.name = commonGenre
        }
        try viewContext.save()
    }
    
}
