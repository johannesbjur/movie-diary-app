//
//  Movies.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-02-05.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation
import Firebase


class Movies {
    
    var movies: [Movie]
    
    var db: Firestore!
    var auth: Auth!
    
    
    init( movies: [Movie] = [] ) {
        
        self.movies = movies
    }
    
    func add( movie: Movie ) {
        
        self.movies.append( movie )
    }
    
    func empty() {
        
        self.movies = []
    }
    
//    save movies to database
    func save()  {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db = Firestore.firestore()
        let moviesRef = db.collection( "users" ).document( uid ).collection( "movies" )
        
        for movie in movies {
            
            moviesRef.addDocument( data: movie.toDict() )
        }
    }
    
//    get movies from database with completion statement
    func update() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db = Firestore.firestore()
        let moviesRef = db.collection( "users" ).document( uid ).collection( "movies" )
        
        moviesRef.getDocuments() { ( querySnapshot, err ) in
            
            guard let documents = querySnapshot?.documents else {return}
            
            self.empty()
            
            for document in documents {
                
                if let movie = Movie( snapshot: document ) {
                    
                    self.add( movie: movie )
                }
            }
        }
        
    }
    
    
    
    
    
}
