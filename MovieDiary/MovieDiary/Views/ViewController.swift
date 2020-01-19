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
        
        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 180

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
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        let movieCell = tableView.dequeueReusableCell( withIdentifier: "MovieCell" ) as! MovieCell
        
        movieCell.setData( withMovie: movie )
        
        return movieCell
    }
    
}

