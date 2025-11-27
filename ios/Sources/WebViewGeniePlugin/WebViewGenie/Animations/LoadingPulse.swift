//
//  LoadingPulse.swift
//  
//  Original code from SwiftfulLoadingIndicators
//  Copyright (c) 2021 Nick Sarno
//  https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators
//  
//  Licensed under MIT License
//  
//  Modified for WebViewGenie plugin
//

import SwiftUI

struct LoadingPulse: View {
    @State var isAnimating: Bool = false
    let timing: Double
    
    let maxCounter: Int = 3
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed * 4
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }

    var body: some View {
        ZStack {
            
            ForEach(0..<maxCounter) { index in
                Circle()
                    .scale(isAnimating ? 1.0 : 0.0)
                    .fill(primaryColor)
                    .opacity(isAnimating ? 0.0 : 1.0)
                    .animation(
                        Animation.easeOut(duration: timing)
                        .repeatForever(autoreverses: false)
                        .delay(Double(index) * timing / 3)
                    )

            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}
