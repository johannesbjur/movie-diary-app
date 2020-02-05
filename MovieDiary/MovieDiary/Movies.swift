//
//  Movies.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-02-05.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation


class Movies {
    
    var movies: [Movie] = []
    
    
    init( movies: [Movie] ) {
        
        self.movies = movies
    }
    
    func add( movie: Movie ) {
        
        self.movies.append( movie )
    }
    
//    save movies to database
    func save()  {
        
    }
    
//    get movies from database with completion statement
    func update() {
        
    }
    
    
    
}
