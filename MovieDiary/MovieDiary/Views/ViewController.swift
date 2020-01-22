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
    @IBOutlet weak var menuView: UIView!
    
    let segToDetailId   = "segHomeToDetail"
    let movieCellId     = "MovieCell"
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.layer.borderWidth = 2
        menuView.layer.borderColor = UIColor.white.cgColor
        
        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 180

//        Test Object
        let mov = Movie( title: "aa", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", rating: 3 )
        movies.append( mov )
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        for movie in movies {
//            print("---")
//            print("title: ", movie.title)
//            print("comment: ", movie.comment)
//            print("rating: ", movie.rating)
//            print("Date: ", movie.date)
//        }
        
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segToDetailId {
            let destVC = segue.destination as! DetailViewController
            
            destVC.movie = sender as? Movie
        }
    }
    
    
    @IBAction func menuPressed(_ sender: UIButton) {
        

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.tableView.transform = CGAffineTransform(translationX: 0, y: 60)
            
            sender.isHidden = true
            self.menuView.isHidden = false
            
        }) { (_) in
            
            
            
        }
        
    }
    
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {}
    
    
//    Number of rows in table view = to number of movie objects in movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    
//    Goes through all cells in tableview and sets data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        let movieCell = tableView.dequeueReusableCell( withIdentifier: movieCellId ) as! MovieCell
        
        movieCell.setData( withMovie: movie )
        
        return movieCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        performSegue( withIdentifier: segToDetailId, sender: movie )
    }
    
    
    
}

