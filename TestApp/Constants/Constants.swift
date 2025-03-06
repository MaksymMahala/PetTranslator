//
//  Constants.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import Foundation

enum Constants {
    enum CatTranslations {
        static let translations: [String: String] = [
            "meow": "I'm hungry, feed me!",
            "purr": "Stroke me)",
            "hiss": "Let's play!",
            "repeat": "Repeat"
        ]
    }
    
    enum DogTranslations {
        static let translations: [String: String] = [
            "bark": "Woof! Let's play",
            "growl": "What are you doing human?",
            "whine": "I need something!",
            "repeat": "Repeat"
        ]
    }
    
    enum HumanTranslations {
        static let translations: [String: String] = [
            "Hello": "Hi there! How are you?",
            "Doodbye": "Goodbye! See you soon.",
            "Thanks": "You're welcome!",
            "Please": "You're polite!",
            "Repeat": "Say something again."
        ]
    }
}
