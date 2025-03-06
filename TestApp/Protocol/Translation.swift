//
//  Translation.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import Foundation

protocol Translation {
    var title1: String { get set }
    var title2: String { get set }
    var isHumanToDog: Bool { get set }
    func swapTitles()
}


protocol Translator {
    func translate() -> String
}
