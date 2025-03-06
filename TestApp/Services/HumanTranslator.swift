//
//  HumanTranslator.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import Foundation

class HumanTranslator: TranslatorHumanPhrase {
    func selectedPhrase(phrase: String, pet: String, soundPlayer: SoundPlayer) {
        if pet == "dog" {
            switch phrase {
            case "Hello":
                soundPlayer.playSound(named: "dog-bark")
            case "Goodbye":
                soundPlayer.playSound(named: "dog-bark-goodbay")
            case "Thanks":
                soundPlayer.playSound(named: "dog-bark-thanks")
            case "Please":
                soundPlayer.playSound(named: "dog-bark-please")
            case "Hungry":
                soundPlayer.playSound(named: "dog-bark-hungry")
            default:
                break
            }
        } else {
            switch phrase {
            case "Hello":
                soundPlayer.playSound(named: "cat-meow")
            case "Goodbye":
                soundPlayer.playSound(named: "cat-meow-goodbay")
            case "Thanks":
                soundPlayer.playSound(named: "cat-meow-thanks")
            case "Please":
                soundPlayer.playSound(named: "cat-meow-please")
            case "Hungry":
                soundPlayer.playSound(named: "cat-repeat")
            default:
                break
            }
        }
    }
}
