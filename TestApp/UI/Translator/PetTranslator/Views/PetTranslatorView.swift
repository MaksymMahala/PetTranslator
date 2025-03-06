//
//  AudioRecorder.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct PetTranslatorView: View {
    @ObservedObject private var viewModel: PetTranslatorViewModel
    @Binding var pet: String
    @Binding var isHumanToDog: Bool

    init(pet: Binding<String>, isHumanToDog: Binding<Bool>) {
        _pet = pet
        _isHumanToDog = isHumanToDog
        _viewModel = ObservedObject(wrappedValue: PetTranslatorViewModel(selectedPet: pet.wrappedValue))
    }
    
    var body: some View {
        VStack {
            if viewModel.isRecording {
                WaveformView(levels: viewModel.soundLevels)
                    .padding()
            }
            
            RecordButton(isRecording: viewModel.isRecording) {
                viewModel.startRecording()
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
                viewModel.stopRecording()
            }
        }
        .padding()
        .frame(width: 178, height: 176)
        .background(Color.white)
        .cornerRadius(10)
        .navigationDestination(isPresented: $viewModel.navigateToNextView) {
            ResultPetSoundView(isHumanToDog: $isHumanToDog, phrase: viewModel.petMessage, pet: pet, action: {
                viewModel.repeatRecording()
            })
        }
        .padding()
    }
}
