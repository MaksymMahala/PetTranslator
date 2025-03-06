//
//  SettingsCell.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct SettingsCell: View {
    @State private var isPressed = false
    let setting: String
    
    var body: some View {
        Button(action: handleTap) {
            cellContent
        }
        .buttonStyle(.plain)
    }
}

private extension Constants {
    enum SettingsCell {
        static let animationDuration: Double = 0.1
        static let pressedScale: CGFloat = 0.95
        static let normalScale: CGFloat = 1.0
        static let pressedOpacity: Double = 0.7
        static let normalOpacity: Double = 1.0
    }
}

private extension SettingsCell {
    var cellContent: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let dynamicCornerRadius = width * 0.05
            let dynamicHeight = width * 0.12
            
            HStack {
                Text(setting)
                    .font(.konkhmerSleokchherRegular16)
                    .foregroundStyle(Color.primary)
                
                Spacer()
                
                Image(.arrowRight)
            }
            .padding()
            .frame(height: dynamicHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.lightPurple)
            .clipShape(RoundedRectangle(cornerRadius: dynamicCornerRadius))
            .padding(.horizontal)
            .scaleEffect(isPressed ? Constants.SettingsCell.pressedScale : Constants.SettingsCell.normalScale)
            .opacity(isPressed ? Constants.SettingsCell.pressedOpacity : Constants.SettingsCell.normalOpacity)
        }
        .frame(height: 50)
    }
}

private extension SettingsCell {
    func handleTap() {
        withAnimation(.easeOut(duration: Constants.SettingsCell.animationDuration)) {
            isPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.SettingsCell.animationDuration) {
            withAnimation(.easeOut(duration: Constants.SettingsCell.animationDuration)) {
                isPressed = false
            }
        }
    }
}
