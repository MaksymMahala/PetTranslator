//
//  TranslatorBothSidePerson.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import SwiftUI

struct TranslatorBothSidePerson: View {
    @Binding var isHumanToDog: Bool
    @Binding var pet: String
    
    var body: some View {
        VStack {
            if isHumanToDog {
                HumanTranslatorView(pet: $pet, isHumanToDog: $isHumanToDog)
            } else {
                PetTranslatorView(pet: $pet, isHumanToDog: $isHumanToDog)
            }
        }
    }
}
