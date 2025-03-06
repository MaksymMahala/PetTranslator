//
//  PetTranslatorViewModel.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import Foundation
import Combine
import SwiftUICore
import AVFoundation

final class PetTranslatorViewModel: ObservableObject {
    @Published var petMessage: String = ""
    @Published var isRecording: Bool = false
    @Published var isRecordingHuman: Bool = false
    @Published var soundLevels: [CGFloat] = []
    @Published var navigateToNextView = false
    @Published var spokenText: String = ""
    @Published var textValue: String = ""
    
    private var soundPlayer: SoundPlayer
    private var speechRecognizer: SpeechRecognizerProtocol
    private var translator: Translator
    private var humanTranslator: TranslatorHumanPhrase
    private let recorderManager: RecorderManagerProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(soundPlayer: SoundPlayer = SoundPlayer(), speechRecognizer: SpeechRecognizerProtocol = SpeechRecognizer(), selectedPet: String, humanTranslator: HumanTranslator = HumanTranslator(), recorderManager: RecorderManagerProtocol = AudioRecorderManager()) {
        self.soundPlayer = soundPlayer
        self.speechRecognizer = speechRecognizer
        self.translator = PetTranslatorViewModel.createTranslator(for: selectedPet)
        self.humanTranslator = humanTranslator
        self.recorderManager = recorderManager
        
        recorderManager.soundLevels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] level in
                guard let self = self else { return }
                self.soundLevels.append(level)
                if self.soundLevels.count > 30 {
                    self.soundLevels.removeFirst()
                }
            }
            .store(in: &cancellables)
    }
    
    private static func createTranslator(for pet: String) -> Translator {
        return pet.lowercased() == "dog" ? DogTranslator() : CatTranslator()
    }

    func updatePet(to newPet: String) {
        translator = PetTranslatorViewModel.createTranslator(for: newPet)
    }
    
    func repeatRecording() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.startRecording()
        }
    }
    
    func startRecording() {
        do {
            try recorderManager.startRecording()
            isRecording = true
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        petMessage = "Process of translation..."
        stopMainRecordFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
            self?.processSound()
        }
    }
    
    func resetMicrophone() {
        recorderManager.stopRecording()
        soundLevels.removeAll()
        isRecording = false
        navigateToNextView = false
        speechRecognizer.stopRecording()
    }
    
    func startHumanRecording(textValue: Binding<String>) {
        startRecording()
        self.textValue = ""
        self.spokenText = ""
        isRecording = true
        speechRecognizer.record(to: textValue)
    }
    
    func stopHumanRecording(pet: String) {
        stopMainRecordFunction()
        spokenText = "Process of translation..."

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            if !self.textValue.isEmpty {
                self.spokenText = self.textValue
                self.textValue = ""
                
                self.humanTranslator.selectedPhrase(phrase: self.spokenText, pet: pet, soundPlayer: self.soundPlayer)
            } else {
                print("Text value is empty, no sound will play.")
            }
            
            self.speechRecognizer.stopRecording()
        }
    }
    
    private func processSound() {
        petMessage = translator.translate()
    }
    
    private func stopMainRecordFunction() {
        if isRecording {
            navigateToNextView = true
        }
        isRecording = false
        recorderManager.stopRecording()
    }
}
