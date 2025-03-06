//
//  CustomTabBar.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        switch selectedTab {
                        case 0:
                            TranslatorView()
                        case 1:
                            ClickerView()
                        default:
                            TranslatorView()
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        TabBarButton(
                            defaultImage: "messages",
                            selectedImage: "messages",
                            title: "Translator",
                            isSelected: selectedTab == 0
                        ) {
                            selectedTab = 0
                        }
                        
                        TabBarButton(
                            defaultImage: "settings",
                            selectedImage: "settings",
                            title: "Clicker",
                            isSelected: selectedTab == 1
                        ) {
                            selectedTab = 1
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .padding(.bottom, 40)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

#Preview {
    CustomTabBarView()
}
