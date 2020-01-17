//
//  ViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let segToAddItemId = "segToAddItem"
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBGroundToGradient()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        for movie in movies {
            print("---")
            print("title: ", movie.title)
            print("comment: ", movie.comment)
        }
        
    }

    
    func setBGroundToGradient() {
        
        let gradientBackground = CAGradientLayer()
        
        gradientBackground.colors = [
            UIColor.init( red: 204.0/255.0, green: 43.0/255.0, blue: 94.0/255.0, alpha: 1 ).cgColor,
            UIColor.init( red: 117.0/255.0, green: 58.0/255.0, blue: 136.0/255.0, alpha: 1 ).cgColor
        ]
        
        gradientBackground.frame = view.frame
        
        view.layer.addSublayer( gradientBackground )
        view.layer.insertSublayer( gradientBackground, at: 0 )
    }
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {}
    
}

