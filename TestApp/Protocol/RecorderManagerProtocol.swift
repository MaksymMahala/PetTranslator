//
//  RecorderManagerProtocol.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import Foundation
import Combine

protocol RecorderManagerProtocol {
    var soundLevels: AnyPublisher<CGFloat, Never> { get }
    
    func startRecording() throws
    func stopRecording()
}
