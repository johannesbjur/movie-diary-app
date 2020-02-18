//
//  ViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var sortByHighestBtn: UIButton!
    @IBOutlet weak var sortByLowestBtn: UIButton!
    @IBOutlet weak var showMenuButton: UIButton!
    @IBOutlet weak var menuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var showSearchButton: UIButton!
    @IBOutlet weak var hideSearchButton: UIButton!

    
    let segToDetailId   = "segHomeToDetail"
    let movieCellId     = "MovieCell"
    
    var db: Firestore!
    
    var movies = Movies()
    var filteredMovies = Movies()
    
    var latestCreatedMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously() { ( authResult, error ) in
            
            guard let user = authResult?.user else { return }
//            let isAnonymous = user.isAnonymous  // true
//            let uid = user.uid
        }
        
        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
//        Hides menu items
        sortByHighestBtn.alpha  = 0
        sortByLowestBtn.alpha   = 0
        searchView.alpha        = 0
        hideSearchButton.alpha  = 0
        menuView.alpha          = 0
        
        menuView.layer.borderWidth  = 2
        menuView.layer.borderColor  = UIColor.white.cgColor
        menuViewHeight.constant     = 70.0
        
        searchTextField.borderStyle = UITextField.BorderStyle.none
        
        let bottomLine = CALayer()
        bottomLine.frame            = CGRect( x: 0.0, y: searchView.frame.height - 1, width: searchView.frame.width, height: 2.0 )
        bottomLine.backgroundColor  = UIColor.white.cgColor
        searchView.layer.addSublayer( bottomLine )

        searchTextField.delegate    = self
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = 180
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
//        Update movies array from database
//        or add movie from create item view with animation
        movies.update() { () in
            
            if let newSaveMovie = self.latestCreatedMovie {
                
                self.filteredMovies.movies.insert(newSaveMovie, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
            }
            else {
                
                self.filteredMovies.empty()
                self.filteredMovies.add( movies: self.movies )
                self.tableView.reloadData()
            }
        }
    }

//    Send selected movie from tableview to detailed view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.tableView.reloadData()
        
        latestCreatedMovie = nil
        
        if segue.identifier == segToDetailId {
            let destVC = segue.destination as! DetailViewController
            
            destVC.movie = sender as? Movie
        }
    }
    
    
//    MARK:- Menu tap functions
    
    @IBAction func menuPressed(_ sender: UIButton) {
        
        showMenu()
    }
    
    @IBAction func showSearchPressed(_ sender: UIButton) {
        
        searchTextField.becomeFirstResponder()
        
        showSearchBar()
    }
    
    @IBAction func hideSearchBarPressed(_ sender: UIButton) {
        
        searchTextField.text = ""
        filteredMovies.empty()
        filteredMovies.add(movies: self.movies)
        tableView.reloadData()
        
        hideSearchBar()
        hideMenu()
    }
    
//    Sorts table view by highest rating
    @IBAction func sortByHighestPressed(_ sender: UIButton) {
        
        filteredMovies.movies = movies.movies.sorted(by: { $0.rating > $1.rating })
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.sortByHighestBtn.alpha = 0.0
            self.sortByLowestBtn.alpha = 1.0
        })
    }
    
//    Sorts table view by lowest rating
    @IBAction func sortByLowestPressed(_ sender: UIButton) {
        
        filteredMovies.movies = movies.movies.sorted(by: { $0.rating < $1.rating })
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.sortByHighestBtn.alpha = 1.0
            self.sortByLowestBtn.alpha = 0.0
        })
    }
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {
        
        if let CIController = segue.source as? CreateItemViewController,
           let movie = CIController.movieToSave {

//            Saves newly created movie item to be added to table view with animation
            latestCreatedMovie = movie
        }
    }
    
    
    
//    MARK:- TableView functions
    
//    Number of rows in table view = to number of movie objects in movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredMovies.movies.count
    }
    
//    Goes through all cells in tableview and sets data to cells
//    and adds long press gestures
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = filteredMovies.movies[indexPath.row]
        let movieCell = tableView.dequeueReusableCell( withIdentifier: movieCellId ) as! MovieCell
        
        movieCell.setStyle()
        movieCell.setData( withMovie: movie )
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.cellLongPressed(_:)))
        movieCell.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.cellRemoveBgTap(_:)))
        movieCell.removeItemBackground.addGestureRecognizer(tapGesture)
        
        return movieCell
    }
    
    
//    Send selected movie object before segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = filteredMovies.movies[indexPath.row]
        
        performSegue( withIdentifier: segToDetailId, sender: movie )
    }

//    MARK:- Remove cell functions
    

//    Hides remove item icon and background when blur background is tapped
    @objc func cellRemoveBgTap(_ sender: UITapGestureRecognizer) {
        
        let pressLocation = sender.location(in: self.tableView)
        
        guard let pressIndexPath    = self.tableView.indexPathForRow(at: pressLocation) else { return }
        guard let pressedCell       = self.tableView.cellForRow(at: pressIndexPath) as? MovieCell else { return }
            
        UIView.animate(withDuration: 0.3, animations: {
            
            pressedCell.removeItemBackground.alpha = 0
        })
    }
    
//    Shows the remove item icon and background
    @objc func cellLongPressed(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            
            let pressLocation = sender.location(in: self.tableView)
            
            guard let pressIndexPath    = self.tableView.indexPathForRow(at: pressLocation) else { return }
            guard let pressedCell       = self.tableView.cellForRow(at: pressIndexPath) as? MovieCell else { return }
                
            if let cells = self.tableView.visibleCells as? [MovieCell] {
                
                for cell in cells {
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        
                        cell.removeItemBackground.alpha = 0
                    })
                }
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                
                pressedCell.removeItemBackground.alpha = 1
            })
        }
    }
    
//    Removes movie from database and table view with animation
    @IBAction func removeMoviePressed(_ sender: UIButton) {
        
        guard let cell      = sender.superview?.superview?.superview as? MovieCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let index     = indexPath[1] as? Int else { return }
        
        let cellMovie = self.filteredMovies.movies[index]
        
        self.movies.delete( movie: cellMovie ) {
            
            self.filteredMovies.empty()
            self.filteredMovies.add( movies: self.movies )
            self.tableView.deleteRows( at: [indexPath], with: .left )
        }
    }
    
//    MARK:- Text field search function
    
//    Uses range to check if any movie title contains search field text whenever search field text changes
    @IBAction func searchFieldDidChange(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        filteredMovies.empty()

        if text == "" {
            
            filteredMovies.add( movies: movies )
        }

        for movie in movies.movies {

            let range  = movie.title.lowercased().range( of: text, options: .caseInsensitive, range: nil, locale: nil )
            
            if range != nil {
                
                self.filteredMovies.add( movie: movie )
            }
        }
        
        tableView.reloadData()
    }

    
    
    

}

