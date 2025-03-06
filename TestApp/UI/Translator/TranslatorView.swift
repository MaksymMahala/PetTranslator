//
//  TranslatorView.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct TranslatorView: View {
    @StateObject private var viewModel = TranslatorViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    background
                    
                    VStack {
                        title
                        
                        translationPersonality
                        
                        bodyBox(geometry: geometry)
                        
                        chosedPet
                    }
                    .padding()
                }
            }
        }
    }
    
    private var background: some View {
        LinearGradient(gradient: Gradient(colors: [Color.lightGreenColor.opacity(0.2), Color.lightGreenColor]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    private var title: some View {
        Text("Translator")
            .foregroundStyle(Color.primary)
            .font(Font.konkhmerSleokchherRegular32)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private var translationPersonality: some View {
        Spacer()
        
        HStack {
            Text(viewModel.translation.title1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            
            Button {
                withAnimation {
                    viewModel.swapTitle()
                }
            } label: {
                Image(.arrowSwap)
            }
            
            Text(viewModel.translation.title2)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
        }
        .foregroundStyle(Color.primary)
        .font(Font.konkhmerSleokchherRegular16)
        
        Spacer()
    }
    
    private func bodyBox(geometry: GeometryProxy) -> some View {
        HStack {
            TranslatorBothSidePerson(isHumanToDog: $viewModel.translation.isHumanToDog, pet: $viewModel.selectedPet)
            
            selectingPetsBox
                .frame(width: geometry.size.width * 0.25)
        }
    }
    
    private var selectingPetsBox: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    viewModel.selectedPet = "cat"
                }
            } label: {
                Image(.pet1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .opacity(viewModel.selectedPet == "dog" ? 0.6 : 1)
            }
            
            Button {
                withAnimation {
                    viewModel.selectedPet = "dog"
                }
            } label: {
                Image(.pet2)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .opacity(viewModel.selectedPet == "cat" ? 0.6 : 1)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    @ViewBuilder
    private var chosedPet: some View {
        Spacer()

        if viewModel.selectedPet == "cat" {
            SceneView(sceneString: "cat.dae")
                .frame(maxWidth: 250, maxHeight: 200)
        } else {
            SceneView(sceneString: "dog.dae")
                .frame(maxWidth: 250, maxHeight: 200)
        }
        
        Spacer()
    }
}

#Preview {
    TranslatorView()
}
