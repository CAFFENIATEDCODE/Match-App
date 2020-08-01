//
//  CarModel.swift
//  Match App
//
//  Created by Ankit on 01/08/20.
//  Copyright © 2020 Varun. All rights reserved.
//

import Foundation


class CarModel{
    
    func getcards() -> [Card] {
        
        //Declare a array to store genereated array cards
        var generatedCardsArray = [Card]()
        
        
        //Randomly genrate pair of cards
        for _ in 1...8 {
            
            //get a random number
            let randomNumebr = Int.random(in: 1...13)
            
            //log random number
            print(randomNumebr)
            
            //create first card object
            let cardOne = Card()
            cardOne.imageNmae = "card\(randomNumebr)"
            
            
            generatedCardsArray.append(cardOne)
            
            
            //create second  card object
                 let cardTwo = Card()
                 cardTwo.imageNmae = "card\(randomNumebr)"
            
            
            generatedCardsArray.append(cardTwo)
            
            
            //OPTIONAL: Make it so we only have unique pairs of cards
        }
        
        //TODO: Randomize the Array
        
        
        //Return the Array
        
        
        return generatedCardsArray
    }
    


}
