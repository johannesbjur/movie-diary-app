//
//  MovieItem.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation

class MovieItem {
    
    var title :String
    var comment :String
    var rating :Int
    
    init( title: String, comment: String, rating: Int) {
        
        self.title      = title
        self.comment    = comment
        self.rating     = rating
    }
    
    
}
