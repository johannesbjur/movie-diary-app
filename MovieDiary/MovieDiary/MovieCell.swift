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
    @IBOutlet weak var removeItemBackground: UIView!
    
    
    func setData( withMovie movie: Movie ) {
        
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
    

    
    func setStyle() {
        
        removeItemBackground.isHidden = false
        removeItemBackground.alpha = 0
        
        if let blurLayer = removeItemBackground.viewWithTag( 100 ) {
            blurLayer.removeFromSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 7
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = removeItemBackground.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 100
        removeItemBackground.insertSubview(blurEffectView, at: 0)
    }
    
    
}
