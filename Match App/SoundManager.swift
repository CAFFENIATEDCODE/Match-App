//
//  SoundManager.swift
//  Match App
//
//  Created by Varun on 02/08/20.
//  Copyright © 2020 Varun. All rights reserved.
//

import Foundation
import AVFoundation


class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
   
    static func playSound(_ effect: SoundEffect) {
        
        var soundFileName = ""
        
        
        
        //Determine which sound effect we want to play
        switch effect {
        case .flip:
            soundFileName = "cardflip"
            
        case .shuffle:
            soundFileName = "shuffle"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .nomatch:
            soundFileName = "dingwrong"
        
    }
        
    //Get the soundle file path
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else {
            print("couldn't file the sound file")
            return
        }
        
        //create a URL object from this string path
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        
        do {
            
            //create audioplayer onbject
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            
            //play the sound
            audioPlayer?.play()
        }
        
        catch {
            // Counldn't create
            print("couldn't create audio player object \(soundFileName)")
        }
        
    }
}



