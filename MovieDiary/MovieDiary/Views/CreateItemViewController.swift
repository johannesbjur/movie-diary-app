//
//  CreateItemViewController.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-16.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import UIKit

class CreateItemViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    @IBOutlet weak var backBtutton: UIButton!
    
    @IBOutlet var starsArray: [UIButton]!
    
    let segToHomeId = "segToHome"
    
    var rating_value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBGroundToGradient()
        
        setStyle( textInput: titleInput )
        setStyle( textInput: commentInput )
        
        
    }

    @IBAction func savePressed(_ sender: UIButton) {
        
        if  let presenter = presentingViewController as? ViewController,
            let title = titleInput.text,
            let comment = commentInput.text {
            
            let movie = Movie( title: title, comment: comment, rating: rating_value )
            
            presenter.movies.append( movie )
        }
        
        dismiss( animated: true, completion: nil )
    }
    
    
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
    
    
    func setStyle( textInput: UITextField ) {
        
        // Create bottom border
        let bottomLine = CALayer()
        bottomLine.frame = CGRect( x: 0.0, y: textInput.frame.height - 1, width: textInput.frame.width, height: 2.0 )
        bottomLine.backgroundColor = UIColor.white.cgColor
        textInput.borderStyle = UITextField.BorderStyle.none
        textInput.layer.addSublayer( bottomLine )
        
        // Create padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.titleInput.frame.height))
        textInput.leftView = paddingView
        textInput.leftViewMode = UITextField.ViewMode.always
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
    


}
