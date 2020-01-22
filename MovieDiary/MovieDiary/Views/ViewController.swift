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
    @IBOutlet weak var starMenuItem: UIButton!
    @IBOutlet weak var showMenuButton: UIButton!
    @IBOutlet weak var menuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    
    let segToDetailId   = "segHomeToDetail"
    let movieCellId     = "MovieCell"
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.alpha = 0.0
        menuView.layer.borderWidth = 2
        menuView.layer.borderColor = UIColor.white.cgColor
        menuViewHeight.constant = 70.0
        
        
        starMenuItem.alpha = 0
        searchView.alpha = 0
        
        
        searchBar.borderStyle = UITextField.BorderStyle.none
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect( x: 0.0, y: searchView.frame.height - 1, width: searchView.frame.width, height: 2.0 )
        bottomLine.backgroundColor = UIColor.white.cgColor
        searchView.layer.addSublayer( bottomLine )
        

        
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
    
    // TODO create toggle menu function or show / hide menu
    
    @IBAction func menuPressed(_ sender: UIButton) {
        
        self.showMenuButton.alpha = 0.0

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.tableView.transform = CGAffineTransform(translationX: 0, y: 60)
            
            self.menuView.alpha = 1.0
            self.starMenuItem.alpha = 1.0
            
            self.menuViewHeight.constant = 135.0
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.layoutIfNeeded()
            })
        })
        
    }
    
    @IBAction func showSearchPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.menuViewHeight.constant = 70.0
            self.menuView.alpha = 0.0
            self.searchView.alpha = 1.0

            self.showMenuButton.alpha = 1.0
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.layoutIfNeeded()
            })
        }, completion: { finished in
                        
        })
    }
    
    @IBAction func hideSearchBarPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.tableView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.searchView.alpha = 0.0
            })
        })
        
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

