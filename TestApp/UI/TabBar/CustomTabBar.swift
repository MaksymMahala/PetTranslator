//
//  CustomTabBar.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @StateObject private var viewModel = CustomTabBarViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        switch viewModel.selectedTab {
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
                            isSelected: viewModel.selectedTab == 0
                        ) {
                            viewModel.selectedTab = 0
                        }
                        
                        TabBarButton(
                            defaultImage: "settings",
                            selectedImage: "settings",
                            title: "Clicker",
                            isSelected: viewModel.selectedTab == 1
                        ) {
                            viewModel.selectedTab = 1
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
