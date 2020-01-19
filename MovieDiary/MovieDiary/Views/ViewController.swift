//
//  ViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let segToAddItemId = "segToAddItem"
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBGroundToGradient()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 180;

//        Test Object
//        let mov = Movie(title: "aa", comment: "bb", rating: 3)
//        movies.append(mov)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        for movie in movies {
            print("---")
            print("title: ", movie.title)
            print("comment: ", movie.comment)
            print("rating: ", movie.rating)
            print("Date: ", movie.date)
        }
        
        self.tableView.reloadData()
    }
    
    
    func setBGroundToGradient() {
        
        let gradientBackground = CAGradientLayer()
        
//        gradientBackground.colors = [
//            UIColor.init( red: 204.0/255.0, green: 43.0/255.0, blue: 94.0/255.0, alpha: 1 ).cgColor,
//            UIColor.init( red: 117.0/255.0, green: 58.0/255.0, blue: 136.0/255.0, alpha: 1 ).cgColor
//        ]
        gradientBackground.colors = [
            Colors.pink,
            Colors.purple
        ]
        
        
        gradientBackground.frame = view.frame
        
        view.layer.addSublayer( gradientBackground )
        view.layer.insertSublayer( gradientBackground, at: 0 )
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        let movieCell = tableView.dequeueReusableCell( withIdentifier: "MovieCell" ) as! MovieCell
        
        movieCell.set( movie: movie )
        
        return movieCell
    }
    
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {}
    
}

