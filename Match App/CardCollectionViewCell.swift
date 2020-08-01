//
//  CardCollectionViewCell.swift
//  Match App
//
//  Created by Ankit on 01/08/20.
//  Copyright © 2020 Varun. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fromImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        //keep track of the card that gets passed in
        self.card = card
        
        if card.isMatched == true {
            
            backImageView.alpha = 0
            fromImageView.alpha = 0
            
            return
            
        }
        else {
            backImageView.alpha = 1
            fromImageView.alpha = 1
            
        }
        
        fromImageView.image = UIImage(named: card.imageNmae)
        
        //determine card is in flipped up state or flipped down state
        if card.isFlipped == true {
            
            UIView.transition(from: backImageView, to: fromImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            

            UIView.transition(from: fromImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
        
    }
    
    func flip() {
        
        UIView.transition(from: backImageView, to: fromImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        
            UIView.transition(from: self.fromImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
         
        
    }
    
    
    func remove() {
        
         //Remove both image from View
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.fromImageView.alpha = 0

            
        }, completion: nil)
        
    }
    
    
}
