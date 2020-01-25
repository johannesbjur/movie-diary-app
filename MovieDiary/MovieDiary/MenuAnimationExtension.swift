//
//  MenuAnimationExtension.swift
//  MovieDiary
//
//  Created by Johannes Bjurströmer on 2020-01-24.
//  Copyright © 2020 Johannes Bjurströmer. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    
    func showMenu() {
        
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
    
    func hideMenu() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.menuViewHeight.constant = 70.0
            self.menuView.alpha = 0.0

            self.showMenuButton.alpha = 1.0
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.layoutIfNeeded()
            })
        })
    }
    
    func showSearchBar() {
        
        self.showSearchButton.alpha = 0
        
        // Show search bar
        self.searchView.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.hideSearchButton.alpha = 1
            
            self.view.layoutIfNeeded()
        })
    }
    
    func hideSearchBar() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.tableView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.searchView.alpha = 0.0
            })
        }, completion: { [weak self] finished in
            self?.showSearchButton.alpha = 1
            self?.hideSearchButton.alpha = 0
        })
    }
    
    
}
