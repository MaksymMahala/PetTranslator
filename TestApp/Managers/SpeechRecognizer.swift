//
//  SpeechRecognizer.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import AVFoundation
import Speech
import SwiftUI

protocol SpeechRecognizerProtocol {
    func record(to speech: Binding<String>)
    func stopRecording()
}

struct SpeechRecognizer: SpeechRecognizerProtocol {
    private class SpeechAssist {
        var audioEngine: AVAudioEngine?
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        let speechRecognizer = SFSpeechRecognizer()

        deinit {
            reset()
        }

        func reset() {
            recognitionTask?.cancel()
            audioEngine?.stop()
            audioEngine = nil
            recognitionRequest = nil
            recognitionTask = nil
        }
    }

    private let assistant = SpeechAssist()

    func record(to speech: Binding<String>) {
        relay(speech, message: "Requesting access")

        canAccess { authorized in
            guard authorized else {
                relay(speech, message: "Access denied. Please enable in Settings.")
                DispatchQueue.main.async {
                    showSettingsAlert()
                }
                return
            }

            relay(speech, message: "Access granted")
            
            assistant.audioEngine = AVAudioEngine()
            guard let audioEngine = assistant.audioEngine else {
                fatalError("Unable to create audio engine")
            }
            assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = assistant.recognitionRequest else {
                fatalError("Unable to create request")
            }
            recognitionRequest.shouldReportPartialResults = true
            
            do {
                relay(speech, message: "Booting audio subsystem")
                
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                
                let inputNode = audioEngine.inputNode
                relay(speech, message: "Found input node")
                
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    recognitionRequest.append(buffer)
                }
                relay(speech, message: "Preparing audio engine")
                
                audioEngine.prepare()
                try audioEngine.start()

                assistant.recognitionTask = assistant.speechRecognizer?.recognitionTask(with: recognitionRequest) { (result, error) in
                    var isFinal = false
                    if let result = result {
                        relay(speech, message: result.bestTranscription.formattedString)
                        isFinal = result.isFinal
                    }

                    if error != nil || isFinal {
                        audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.assistant.recognitionRequest = nil
                    }
                }
            } catch {
                print("Error transcribing audio: \(error.localizedDescription)")
                assistant.reset()
            }
        }
    }

    func stopRecording() {
        assistant.reset()
    }

    private func canAccess(withHandler handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            if status == .authorized {
                if #available(iOS 17.0, *) {
                    AVAudioApplication.requestRecordPermission { authorized in
                        handler(authorized)
                    }
                } else {
                    AVAudioSession.sharedInstance().requestRecordPermission { authorized in
                        handler(authorized)
                    }
                }
            } else {
                handler(false)
            }
        }
    }

    private func relay(_ binding: Binding<String>, message: String) {
        DispatchQueue.main.async {
            binding.wrappedValue = message
        }
    }

    private func showSettingsAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController else { return }

        let alert = UIAlertController(
            title: "Enable Microphone Access",
            message: "Please allow access to your microphone in Settings to use the app’s features.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }))

        rootVC.present(alert, animated: true)
    }
}
