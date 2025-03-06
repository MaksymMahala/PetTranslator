//
//  HumanPetTranslation.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import Foundation
import SwiftUICore

class HumanPetTranslation: Translation {
    var title1: String = "HUMAN"
    var title2: String = "PET"
    var isHumanToDog: Bool = true
    
    func swapTitles() {
        if title1 == "HUMAN" {
            title1 = "PET"
            title2 = "HUMAN"
            isHumanToDog = false
        } else {
            title1 = "HUMAN"
            title2 = "PET"
            isHumanToDog = true
        }
    }
}
