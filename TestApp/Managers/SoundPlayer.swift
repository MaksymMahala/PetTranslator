//
//  SoundPlayer.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import Foundation
import AVFoundation

class SoundPlayer {
    private var audioPlayer: AVAudioPlayer?

    func playSound(named soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file \(soundName).mp3 not found!")
            return
        }
        
        do {
            // Initialize the audio player with the sound file URL
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()  // Play the sound
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
