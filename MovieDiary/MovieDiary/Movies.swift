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
    
    func add( movies: Movies ) {
        
        for movie in movies.movies {
            
            self.movies.append( movie )
        }
    }
    
    func empty() {
        
        self.movies = []
    }
    
//    Saves movies to database
    func save()  {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db = Firestore.firestore()
        let moviesRef = db.collection( "users" ).document( uid ).collection( "movies" )
        
        for movie in movies {
            
            moviesRef.addDocument( data: movie.toDict() )
        }
    }
    
//    Deletes movie from database and movies array
//    accepts completion handler used for updating tableview data
    func delete( movie: Movie, completion: @escaping () -> () ) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db = Firestore.firestore()
        let moviesRef = db.collection( "users" ).document( uid ).collection( "movies" )
        
        moviesRef.whereField("title", isEqualTo: movie.title).getDocuments() { ( querySnapshot, error ) in
            
            guard let documents = querySnapshot?.documents else { return }
            
            for document in documents {
                
                document.reference.delete()
            }
            
            if let index = self.movies.firstIndex(where: {$0.title == movie.title}) {
                
                self.movies.remove(at: index)
            }
            
            completion()
        }
    }
    
//    Gets movies from database with completion statement
//    accepts completion handler used for updating tableview data
    func update( completion: @escaping () -> () ) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db = Firestore.firestore()
        let moviesRef = db.collection( "users" ).document( uid ).collection( "movies" )
        
        moviesRef.getDocuments() { ( querySnapshot, err ) in
            
            guard let documents = querySnapshot?.documents else { return }
            
            self.empty()
            
            for document in documents {
                
                if let movie = Movie( snapshot: document ) {
                    
                    self.add( movie: movie )
                }
            }
            
            completion()
        }
    }
    
    
    
}
