//
//  GenreSelectionView.swift
//  MovieManager
//
//  Created by Alfonso Gonzalez Miramontes on 28/11/24.
//

import SwiftUI

struct GenreSelectionView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Genre.name, order: .forward)]) private var genres: FetchedResults<Genre>
    
    @Binding var selectedGenres: Set<Genre>
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(genres){genre in
                    Text(genre.name ?? "")
                        .frame(width: 100, height: 100)
                        .background(selectedGenres.contains(genre) ? .movieSecondary : .gray)
                        .clipShape(Circle())
                        .foregroundStyle(.movieForeground)
                        .font(.system(size: 15))
                        .onTapGesture{
                            if selectedGenres.contains(genre){
                                selectedGenres.remove(genre)
                            }else{
                                selectedGenres.insert(genre)
                            }
                        }
                        .scrollTransition{content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.25, y: phase.isIdentity ? 1 : 0.25)
                                .rotationEffect(.degrees(phase.isIdentity ? 0 : -90))
                                .offset(y: phase.isIdentity ? 0 : 50)
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct GenreSelectionViewContainer: View {
    
    @State private var selectedGenres: Set<Genre> = []
    
    var body: some View{
        GenreSelectionView(selectedGenres: $selectedGenres)
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}

#Preview {
    GenreSelectionViewContainer()
}
