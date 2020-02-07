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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        view.setGradientBackground( colorOne: Colors.pink, colorTwo: Colors.purple )
        
        setStyle( textInput: titleInput )
        setStyle( textInput: commentInput )
        
        titleInput.becomeFirstResponder()
    }

//    Creates movie object from user input and sends to home screen
    @IBAction func savePressed(_ sender: UIButton) {
        
        guard let title     = titleInput.text else { return }
        guard let comment   = commentInput.text else { return }
        
        let movie = Movie( title: title, comment: comment, rating: self.rating_value )
        
        movieToSave = movie
        
        self.movies.add( movie: movie )
        self.movies.save()
        
        performSegue(withIdentifier: segToHomeId, sender: self)
    }
    
//    Handles graphics for rating stars
    @IBAction func starPressed(_ sender: UIButton) {
        
        rating_value = sender.tag
        
        for star in starsArray {
            
            if star.tag <= sender.tag {
                star.setBackgroundImage(UIImage.init(named: "full_star_white"), for: .normal)
            }
            else {
                star.setBackgroundImage(UIImage.init(named: "empty_star_white"), for: .normal)
            }
        }
    }
    
// TODO move to shared file / extension
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
