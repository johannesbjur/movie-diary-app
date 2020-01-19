//
//  UIViewExtension.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-19.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground( colorOne: UIColor, colorTwo: UIColor ) {
        
        let gradientBackground = CAGradientLayer()
                
        gradientBackground.colors = [
            colorOne.cgColor,
            colorTwo.cgColor
        ]
        gradientBackground.frame = bounds
        gradientBackground.locations = [ 0.0, 1.0 ]
        
//        Gradient positioning
//        gradientBackground.startPoint = CGPoint( x: 1.0, y: 1.0 )
//        gradientBackground.endPoint = CGPoint( x: 0.0, y: 0.0 )
        
        layer.addSublayer( gradientBackground )
        layer.insertSublayer( gradientBackground, at: 0 )
    }
    
}
