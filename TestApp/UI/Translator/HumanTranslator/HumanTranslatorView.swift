//
//  HumanTranslatorView.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import SwiftUI

struct HumanTranslatorView: View {
    @ObservedObject private var viewModel: PetTranslatorViewModel
    @Binding var pet: String
    @Binding var isHumanToDog: Bool
    
    init(pet: Binding<String>, isHumanToDog: Binding<Bool>) {
        _pet = pet
        _viewModel = ObservedObject(wrappedValue: PetTranslatorViewModel(selectedPet: pet.wrappedValue))
        _isHumanToDog = isHumanToDog
    }
    
    var body: some View {
        VStack {
            if viewModel.isRecording {
                WaveformView(levels: viewModel.soundLevels)
                    .padding()
            }
            
            RecordButton(isRecording: viewModel.isRecording) {
                viewModel.startHumanRecording(textValue: $viewModel.textValue)
            }
        }
        .onAppear {
            viewModel.resetMicrophone()
        }
        .onChange(of: pet) { newPet in
            viewModel.updatePet(to: pet)
        }
        .onChange(of: viewModel.soundLevels) { newSoundLevels in
            if newSoundLevels.count > 25 {
                viewModel.stopHumanRecording(pet: pet)
            }
        }
        .padding()
        .frame(width: 178, height: 176)
        .background(Color.white)
        .cornerRadius(10)
        .navigationDestination(isPresented: $viewModel.navigateToNextView) {
            ResultPetSoundView(isHumanToDog: $isHumanToDog, phrase: viewModel.spokenText, pet: pet, action: {
                viewModel.repeatRecording()
            })
        }
        .padding()
    }
}
