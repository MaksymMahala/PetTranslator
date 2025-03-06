//
//  TranslationTextView.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import SwiftUI

struct TranslationTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(Font.konkhmerSleokchherRegular12)
            .foregroundStyle(Color.black)
            .padding()
    }
}
