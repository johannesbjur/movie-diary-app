//
//  CreateItemViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit
import Firebase

class CreateItemViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    @IBOutlet weak var backBtutton: UIButton!
    
    @IBOutlet var starsArray: [UIButton]!
    
    var db: Firestore!
    
    var rating_value: Int = 0
    var movies = Movies()
    
    let segToHomeId = "segToHome"
    
    var movieToSave: Movie?
    var movieToEdit: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
        setStyle( textInput: titleInput )
        setStyle( textInput: commentInput )
        
        titleInput.becomeFirstResponder()
        
        if let movieToEdit = movieToEdit {
            
            titleInput.text     = movieToEdit.title
            commentInput.text   = movieToEdit.comment
            self.rating_value   = movieToEdit.rating
            ratingSetTo( value: movieToEdit.rating )
        }
        
    }

//    Creates movie object from user input and sends to home screen
    @IBAction func savePressed(_ sender: UIButton) {
        
        guard let title     = titleInput.text else { return }
        guard var comment   = commentInput.text else { return }
        
        comment = comment.prefix(1).uppercased() + comment.dropFirst()
        
        let movie = Movie( title: title.capitalized, comment: comment, rating: self.rating_value )
        
//        If movie is being edited save set firestore id
//        else add to movieToSave for tableview animation
        if let movieToEdit = movieToEdit {
            
            movie.fireStoreId = movieToEdit.fireStoreId
        }
        else {
            
            movieToSave = movie
        }
        
        self.movies.add( movie: movie )
        self.movies.save()
        
        performSegue(withIdentifier: segToHomeId, sender: self)
    }
    
//    Handles graphics for rating stars
    @IBAction func starPressed(_ sender: UIButton) {
        
        rating_value = sender.tag
        ratingSetTo( value: sender.tag )        
    }
    
    func ratingSetTo( value: Int ) {
        
        for star in starsArray {
            
            if star.tag <= value {
                star.setBackgroundImage(UIImage.init(named: "full_star_white"), for: .normal)
            }
            else {
                star.setBackgroundImage(UIImage.init(named: "empty_star_white"), for: .normal)
            }
        }
    }

    
//    Sets custom style for text inputs
    func setStyle( textInput: UITextField ) {
        
        // Create bottom border
        let bottomLine = CALayer()
        bottomLine.frame = CGRect( x: 0.0, y: textInput.frame.height - 1, width: textInput.frame.width, height: 2.0 )
        bottomLine.backgroundColor = UIColor.white.cgColor
        textInput.borderStyle = UITextField.BorderStyle.none
        textInput.layer.addSublayer( bottomLine )
        
        // Create padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: textInput.frame.height))
        textInput.leftView = paddingView
        textInput.leftViewMode = UITextField.ViewMode.always
    }


}
