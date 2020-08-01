//
//  ViewController.swift
//  Match App
//
//  Created by Varun on 01/08/20.
//  Copyright © 2020 Varun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model = CarModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?

    var timer:Timer?
    var milliseconds:Float = 1000 * 10 // 10 seconds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getcards()
        
        //create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }

    
    //MARK: - Timer Methods
    
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        
        //Express in seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timeLabel.text = "Time Remaining \(seconds)"
        
        //stop when reaches 0
        
        if milliseconds <= 0 {
            
            timer?.invalidate()
            timeLabel.textColor = UIColor.red
            
            //check if cards are left
            checkGameEnded()
            
        }
    }
    
    //MARK: - UICollectionView Protocols Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        
        //Get an Card Collection view Object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //get the card that collectionView trying to display
        let card = cardArray[indexPath.row]
        
        //set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if there is any time left
        if milliseconds <= 0 {
            return
        }
        
        //Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            //Flip the card
             cell.flip()
            
            //play the flip sound
            
            SoundManager.playSound(.flip)
             
            //set the status of the card
            card.isFlipped = true
            
            
            //Determine if it's first card or second card flipped over
            
            if firstFlippedCardIndex == nil {
                
                //This is the first card being flipped
                firstFlippedCardIndex = indexPath
            }
            else {
                
                //THis is the second card being flipped
                
                // Perform the matching logic
                checkForMatches(indexPath)
                
            }
            
        }

    }
    
    
    
    //Mark :- Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        //Get the cells for the two cards that were revealed
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //compare two cards
        if cardOne.imageNmae == cardTwo.imageNmae {
            //It's a match
            
            // Match Sound
            SoundManager.playSound(.match)
            
            //Set the status of cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            
        }
        else {
            
            //It's not a match
            
            // Not Match Sound
            SoundManager.playSound(.nomatch)
            
            //Set the status of cards
            cardOne.isMatched = false
            cardTwo.isMatched = false
            
            //Flip both cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
            
            
        }
        
    }
    
    
    func  checkGameEnded()  {
        
        //determine if their are any cards unmatched
        var isWon = true
        var title = ""
        var message = ""
        //if not user won
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
            
        }
        
        
        if isWon {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You Won"
            
        }
        else {
            
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "YOU LOST"
            
        }
        
        showAlert(title, message)
        
        
    }
    
    func showAlert(_ title: String, _ message: String ){
        
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

}

