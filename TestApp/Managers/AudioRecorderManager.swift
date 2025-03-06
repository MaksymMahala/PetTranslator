//
//  AudioRecorderManager.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI
import AVFoundation
import Combine

final class AudioRecorderManager: RecorderManagerProtocol {
    private var audioRecorder: AVAudioRecorder?
    private let audioSession: AVAudioSession
    private let fileManager: FileManager
    private let updateInterval: TimeInterval
    private var soundTimer: Timer?
    
    private let soundLevelsSubject = PassthroughSubject<CGFloat, Never>()
    
    var soundLevels: AnyPublisher<CGFloat, Never> {
        soundLevelsSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    init(audioSession: AVAudioSession = .sharedInstance(),
         fileManager: FileManager = .default,
         updateInterval: TimeInterval = 0.1) {
        self.audioSession = audioSession
        self.fileManager = fileManager
        self.updateInterval = updateInterval
    }
    
    // MARK: - Audio Session Configuration
    private func configureAudioSession() throws {
        try audioSession.setCategory(.playAndRecord,
                                     mode: .default,
                                     options: .defaultToSpeaker)
        try audioSession.setActive(true)
    }
    
    private func getRecordingURL() -> URL {
        return fileManager.temporaryDirectory.appendingPathComponent("recording.m4a")
    }
    
    // MARK: - Recording Control
    func startRecording() throws {
        try configureAudioSession()
        
        let url = getRecordingURL()
        audioRecorder = try AVAudioRecorder(url: url, settings: [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ])
        
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.record()
        
        startMonitoring()
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        stopMonitoring()
    }
    
    
    private func startMonitoring() {
        stopMonitoring()
        
        soundTimer = Timer.scheduledTimer(withTimeInterval: updateInterval,
                                          repeats: true) { [weak self] _ in
            guard let self = self, let recorder = self.audioRecorder else { return }
            recorder.updateMeters()
            let level = max(10, CGFloat((recorder.averagePower(forChannel: 0) + 60) * 2))
            self.soundLevelsSubject.send(level)
        }
    }
    
    private func stopMonitoring() {
        soundTimer?.invalidate()
        soundTimer = nil
    }
}
