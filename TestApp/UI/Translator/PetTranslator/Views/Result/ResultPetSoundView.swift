//
//  ResultPetSoundView.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import SwiftUI

struct ResultPetSoundView: View {
    @Binding var isHumanToDog: Bool
    @Environment(\.dismiss) var dismiss
    var phrase: String
    var pet: String
    var action: () -> ()
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                title
                
                Spacer()
                
                mainbody
                
                Spacer()
                
                selectedPet
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var background: some View {
        LinearGradient(gradient: Gradient(colors: [Color.lightGreen.opacity(0.2), Color.lightGreen]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    private var title: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(.close)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 28, height: 28)
                    .padding(7)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.leading)
            }
            
            Spacer()

            
            Text("Result")
                .font(Font.konkhmerSleokchherRegular32)
                .foregroundStyle(Color.primary)
                .padding(.trailing, 50)
            
            Spacer()
        }
    }
    
    private var mainbody: some View {
        ZStack(alignment: .center) {
            if phrase == "Process of translation..." {
                phraseView
            } else {
                if isHumanToDog {
                    shouldShowRepeatButton(for: phrase) ? AnyView(repeatButton) : AnyView(phraseView)
                } else {
                    if phrase == "Repeat" {
                        repeatButton
                    } else {
                        phraseView
                    }
                }
            }
        }
    }
    
    private func shouldShowRepeatButton(for phrase: String) -> Bool {
        !Constants.HumanTranslations.translations.keys.contains(phrase)
    }
    
    private var repeatButton: some View {
        Button {
            action()
            dismiss()
        } label: {
            HStack {
                Image(.rotateRight)
                Text("Repeat")
                    .foregroundStyle(Color.black)
                    .font(Font.konkhmerSleokchherRegular12)
            }
            .frame(width: 291, height: 54, alignment: .center)
            .background(Color.lightPurple)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    @ViewBuilder
    private var phraseView: some View {
        Image(.cloud)
            .resizable()
            .scaledToFill()
            .frame(width: 291, height: 142)
        
        Text(phrase)
            .foregroundStyle(Color.black)
            .font(Font.konkhmerSleokchherRegular12)
            .frame(width: 280, height: 135, alignment: .top)
    }
    
    private var selectedPet: some View {
        if pet == "cat" {
            SceneView(sceneString: "cat.dae")
                .frame(width: 250, height: 200)
        } else {
            SceneView(sceneString: "dog.dae")
                .frame(width: 250, height: 200)
        }
    }
}

#Preview {
    ResultPetSoundView(isHumanToDog: .constant(false), phrase: "Repeat", pet: "dog", action: {})
}
