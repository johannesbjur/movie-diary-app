//
//  MovieCell.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-19.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet var ratingStars: [UIButton]!

    
    func set( movie: Movie ) {
        
        self.movieTitle.text = movie.title
        
        
        for star in ratingStars {
            
            if star.tag <= movie.rating {
                
                star.setBackgroundImage( UIImage.init( named: "full_star_colored" ), for: .normal )
            }
            else {
                
                star.setBackgroundImage( UIImage.init( named: "empty_star_colored" ), for: .normal )
            }
        }
    }
    
    
    
}
