//
//  ViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

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
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
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

        
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.rowHeight     = 180
        
        
        searchTextField.delegate = self
        searchTextField.addTarget( self, action: #selector( self.textFieldDidChange(_:) ), for: UIControl.Event.editingChanged )

        
//        Test Objects
//        let mov     = Movie( title: "aa", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", rating: 3 )
//        let mov2    = Movie( title: "bb", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", rating: 4 )
//        movies.append( mov )
//        movies.append( mov2 )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        for movie in movies {
//            print("---")
//            print("title: ", movie.title)
//            print("comment: ", movie.comment)
//            print("rating: ", movie.rating)
//            print("Date: ", movie.date)
//        }
        
        self.filteredMovies = movies
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
        filteredMovies = movies
        tableView.reloadData()
        
        hideSearchBar()
        hideMenu()
    }
    
    @IBAction func sortByHighestPressed(_ sender: UIButton) {
        
        filteredMovies = movies.sorted(by: { $0.rating > $1.rating })
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.sortByHighestBtn.alpha = 0.0
            self.sortByLowestBtn.alpha = 1.0
        })
    }
    
    @IBAction func sortByLowestPressed(_ sender: UIButton) {
        
        filteredMovies = movies.sorted(by: { $0.rating < $1.rating })
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.sortByHighestBtn.alpha = 1.0
            self.sortByLowestBtn.alpha = 0.0
        })
    }
    
    @IBAction func unwindToHome( segue: UIStoryboardSegue ) {}
    
    
    
//    MARK:- TableView functions
    
//    Number of rows in table view = to number of movie objects in movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredMovies.count
    }
    
//    Goes through all cells in tableview and sets data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = filteredMovies[indexPath.row]
        let movieCell = tableView.dequeueReusableCell( withIdentifier: movieCellId ) as! MovieCell
        
        movieCell.setData( withMovie: movie )
        
        return movieCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = filteredMovies[indexPath.row]
        performSegue( withIdentifier: segToDetailId, sender: movie )
    }
    
    
//    MARK:- Text field search function
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else {return}
        
        if text == "" {
            filteredMovies = movies
        }
        else {
            filteredMovies = []
        }
        
        for movie in movies {
            
            let range  = movie.title.lowercased().range(of: text, options: .caseInsensitive, range: nil, locale: nil)
            
            if range != nil {
                
                self.filteredMovies.append(movie)
            }
        }
        
        tableView.reloadData()
    }
    
    
    

}
