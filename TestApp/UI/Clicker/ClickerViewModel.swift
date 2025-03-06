//
//  ClickerViewModel.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import Foundation

class ClickerViewModel: ObservableObject {
    @Published var isPressed = false
    var settingsList = ["Rate us", "Share App", "Contact Us", "Restore Purchases", "Privacy Policy", "Terms of Use"]
}
