//
//  TranslatorViewModel.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import Foundation

class TranslatorViewModel: ObservableObject {
    @Published var translation: Translation
    @Published var selectedPet: String = "cat"

    init(translation: Translation = HumanPetTranslation()) {
        self.translation = translation
    }
    
    func swapTitle() {
        translation.swapTitles()
        
        if let humanPetTranslation = translation as? HumanPetTranslation {
            translation = humanPetTranslation
        }
    }
}
