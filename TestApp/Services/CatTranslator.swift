//
//  CatTranslator.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import Foundation

class CatTranslator: Translator {
    func translate() -> String {
        let randomSound = ["meow", "purr", "hiss", "repeat"].randomElement() ?? "meow"
        return Constants.CatTranslations.translations[randomSound] ?? "Unknown cat sound"
    }
}
