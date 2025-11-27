import Foundation
import UIKit
import Capacitor

public struct LoadingConfig {
    let animation: String
    let color: String
    let size: CGFloat
    let speed: Double
    
    static var `default`: LoadingConfig {
        return LoadingConfig(
            animation: "loadingThreeBalls",
            color: "#000000",
            size: 50.0,
            speed: 0.5
        )
    }
    
    init(from jsObject: JSObject?) {
        guard let options = jsObject else {
            self = LoadingConfig.default
            return
        }
        
        if let animationValue = options["animation"] as? String {
            self.animation = animationValue
        } else {
            self.animation = "loadingThreeBalls"
        }
        
        if let colorValue = options["color"] as? String {
            self.color = colorValue
        } else {
            self.color = "#000000"
        }
        
        if let sizeValue = options["size"] as? Double {
            self.size = CGFloat(sizeValue)
        } else if let sizeValue = options["size"] as? Int {
            self.size = CGFloat(sizeValue)
        } else {
            self.size = 50.0
        }
        
        if let speedValue = options["speed"] as? Double {
            self.speed = speedValue
        } else if let speedValue = options["speed"] as? Int {
            self.speed = Double(speedValue)
        } else {
            self.speed = 0.5
        }
    }
    
    private init(animation: String, color: String, size: CGFloat, speed: Double) {
        self.animation = animation
        self.color = color
        self.size = size
        self.speed = speed
    }
}
