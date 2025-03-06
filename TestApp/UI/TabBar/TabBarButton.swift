//
//  TabBarButton.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct TabBarButton: View {
    var defaultImage: String
    var selectedImage: String
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            Image(isSelected ? selectedImage : defaultImage)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(isSelected ? Color.black : Color.gray.opacity(0.8))
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(Font.konkhmerSleokchherRegular12)
                .foregroundStyle(isSelected ? Color.black : Color.gray)
        }
        .padding(5)
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                action()
            }
        }
    }
}
