//
//  LoadingIndicator.swift
//  App
//
//  Created by   TeamCity Agent on 26.11.2025.
//

import Foundation
import UIKit
import SwiftUI


public class LoadingIndicator {
    
    public enum AnimationType {
        case loadingBar
        case loadingCircleRunner
        case loadingThreeBalls
        case loadingThreeBallsRotation
        case loadingThreeBallsBouncing
        case loadingPulse
        case loadingCircleBlinks

    init(from string: String) {
        switch string {
        case "loadingBar":
            self = .loadingBar
        case "loadingCircleRunner":
            self = .loadingCircleRunner
        case "loadingThreeBalls":
            self = .loadingThreeBalls
        case "loadingThreeBallsRotation":
            self = .loadingThreeBallsRotation
        case "loadingThreeBallsBouncing":
            self = .loadingThreeBallsBouncing
        case "loadingPulse":
            self = .loadingPulse
        case "loadingCircleBlinks":
            self = .loadingCircleBlinks
        default:
            self = .loadingThreeBalls
        }
      }
    }
    
    
    private weak var parentView: UIView?
    private var animation: AnimationType
    private var color: Color
    private var size: CGFloat
    private var speed: Double
    private var hostingController: UIHostingController<AnyView>?
    
    init(view: UIView, config: LoadingConfig) {
        self.parentView = view
        self.animation = AnimationType(from: config.animation)
        self.color = Color(hex: config.color)
        self.size = config.size
        self.speed = config.speed
    }
    
    
    public func show() {
        guard hostingController == nil, let parentView = parentView else { return }
        
        let animationView = self.createAnimation()
        let hostingController = UIHostingController(rootView: animationView)

        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            hostingController.view.widthAnchor.constraint(equalToConstant: size),
            hostingController.view.heightAnchor.constraint(equalToConstant: size)
        ])
                
        self.hostingController = hostingController
    }
    
    public func hide() {
        self.hostingController?.view.removeFromSuperview()
        self.hostingController = nil
    }
    
    private func createAnimation() -> AnyView {
        switch animation {
        case .loadingBar:
            return AnyView(LoadingBar(color: color, size: size, speed: speed))
        case .loadingCircleRunner:
            return AnyView(LoadingCircleRunner(color: color, size: size, speed: speed))
        case .loadingThreeBalls:
            return AnyView(LoadingThreeBalls(color: color, size: size, speed: speed))
        case .loadingThreeBallsRotation:
            return AnyView(LoadingThreeBallsRotation(color: color, size: size, speed: speed))
        case .loadingThreeBallsBouncing:
            return AnyView(LoadingThreeBallsBouncing(color: color, size: size, speed: speed))
        case .loadingPulse:
            return AnyView(LoadingPulse(color: color, size: size, speed: speed))
        case .loadingCircleBlinks:
            return AnyView(LoadingCircleBlinks(color: color, size: size, speed: speed))
        }
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
