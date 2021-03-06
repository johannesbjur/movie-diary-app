//
//  DetailViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-20.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var ratingStars: [UIButton]!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
        
            titleLabel.text     = movie.title
            commentLabel.text   = movie.comment
            dateLabel.text      = movie.date
            
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

    

}
