//
//  PlaySound.swift
//  ResurrectionSD
//
//  Created by Mohh Gupta on 4/6/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer  = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch{
            print("couldn't play audio file")
        }
    }
}


