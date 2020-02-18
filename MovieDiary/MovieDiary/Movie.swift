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
    
    var title: String
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
    
    
//    Constructor using item from database
//    Returns nil if a value is missing
    init?( snapshot: QueryDocumentSnapshot  ) {
        
        let snapshotValue = snapshot.data() as [String: Any]
        
        guard let title     = snapshotValue["title"] as? String else { return nil }
        guard let comment   = snapshotValue["comment"] as? String else { return nil }
        guard let rating    = snapshotValue["rating"] as? Int else { return nil }
        guard let date      = snapshotValue["date"] as? String else { return nil }
        
        
        self.title      = title
        self.comment    = comment
        self.rating     = rating
        self.date       = date
    }
    
//    Returns movie item as dictionary to save in firebase
    func toDict() -> [String: Any] {
        
        return [
            "title":   self.title,
            "comment": self.comment,
            "rating":  self.rating,
            "date":    self.date
        ]
    }
    
    
}
