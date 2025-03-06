//
//  SceneView.swift
//  TestApp
//
//  Created by Max on 06.03.2025.
//

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    let sceneString: String
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.frame = CGRect(x: 20, y: 400, width: 300, height: 200)
        sceneView.backgroundColor = .clear
        loadScene(into: sceneView, named: sceneString)
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        loadScene(into: uiView, named: sceneString)
    }

    private func loadScene(into sceneView: SCNView, named sceneName: String) {
        if let scene = SCNScene(named: sceneName) {
            sceneView.scene = scene
        }
    }
}
