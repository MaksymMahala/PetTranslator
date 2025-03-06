//
//  DogTranslator.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import Foundation

class DogTranslator: Translator {
    func translate() -> String {
        let randomSound = ["bark", "growl", "whine", "repeat"].randomElement() ?? "bark"
        return Constants.DogTranslations.translations[randomSound] ?? "Unknown dog sound"
    }
}
