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
    
    let segToHomeId = "segToHome"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBGroundToGradient()
        
        setInputBorder( textInput: titleInput )
        setInputBorder( textInput: commentInput )
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.titleInput.frame.height))
        titleInput.leftView = paddingView
        titleInput.leftViewMode = UITextField.ViewMode.always
        
        // chrashes i paddingView is user a second time
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.commentInput.frame.height))
        commentInput.leftView = paddingView2
        commentInput.leftViewMode = UITextField.ViewMode.always
        
        

        
        
    }
    
    @IBAction func backArrowPressed(_ sender: UIButton) {
        
        
        
        performSegue(withIdentifier: segToHomeId, sender: self)
    }
    
    func setInputBorder( textInput: UITextField ) {
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect( x: 0.0, y: textInput.frame.height - 1, width: textInput.frame.width, height: 2.0 )
        bottomLine.backgroundColor = UIColor.white.cgColor
        textInput.borderStyle = UITextField.BorderStyle.none
        textInput.layer.addSublayer( bottomLine )
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
