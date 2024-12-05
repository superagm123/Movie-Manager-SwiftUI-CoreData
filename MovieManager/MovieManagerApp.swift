//
//  MovieManagerApp.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 26/11/24.
//

import SwiftUI

@main
struct MovieManagerApp: App {
    
    let provider: CoreDataProvider
    let genreSeeder: GenreSeeder
    
    init(){
        provider = CoreDataProvider()
        genreSeeder = GenreSeeder(viewContext: provider.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainScreen()
                    .onAppear{
                        let hasSeededData = UserDefaults.standard.bool(forKey: "hasSeededData")
                        
                        if !hasSeededData{
                            let commonGenres = ["Action", "Comedy", "Romance", "Fantasy", "Horror", "Drama", "Sci-fi", "Mystery", "Thriller", "Western", "War", "Animation", "Documentary"]
                            do{
                                try genreSeeder.seed(commonGenres)
                                UserDefaults.standard.setValue(true, forKey: "hasSeededData")
                            }catch{
                                print(error)
                            }
                        }
                    }
            }
            .environment(\.managedObjectContext, provider.viewContext)
        }
    }
}
