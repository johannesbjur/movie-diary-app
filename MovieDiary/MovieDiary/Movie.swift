//
//  Movie.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-17.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation
import Firebase

class Movie {
    
    var title: String = ""
    let comment: String
    let rating: Int
    let date: String
    
    init( title: String, comment: String, rating: Int ) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        self.title      = title
        self.comment    = comment
        self.rating     = rating
        self.date       = formatter.string( from: Date() )
    }
    
    init( snapshot: QueryDocumentSnapshot ) {
        
        let snapshotValue = snapshot.data() as [String: Any]
        
        
//        TODO: change unwrapping (!)
        self.title = snapshotValue["title"] as! String
        self.comment = snapshotValue["comment"] as! String
        self.rating = snapshotValue["rating"] as! Int
        self.date = snapshotValue["date"] as! String
    }
    
    func toDict() -> [String: Any] {
        
        return [
            "title":   self.title,
            "comment": self.comment,
            "rating":  self.rating,
            "date":    self.date
        ]
    }
    
    
    
    
    
    
    
}
