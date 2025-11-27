//
//  WebViewGeniePlugin.swift
//  App
//
//  Created by   TeamCity Agent on 25.11.2025.
//

import Foundation
import Capacitor


@objc(WebViewGeniePlugin)
public class WebViewGeniePlugin : CAPPlugin, CAPBridgedPlugin {
    public let identifier = "WebViewGeniePlugin"
    public let jsName = "WebViewGenie"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "open", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "close", returnType: CAPPluginReturnPromise)
    ]

    private var implementation: WebViewGenie!
    
    override public func load() {
        implementation = WebViewGenie(plugin: self)
    }

    @objc public func open(_ call: CAPPluginCall) {
        guard let urlString = call.getString("url") else {
            call.reject("URL parameter is required")
            return
        }
        
        
        let options = LoadingConfig(from: call.getObject("ios"))

        DispatchQueue.main.async {
            guard let viewController = self.bridge?.viewController else {
                call.reject("Unable to get view controller")
                return
            }
            
            self.implementation.openUrl(urlString, from: viewController, call: call, options: options)
        }
    }
    
    @objc public func close(_ call: CAPPluginCall) {
        
        DispatchQueue.main.async {
            self.implementation.closeWebView()
            call.resolve()
        }
    }
    
    @objc public func navigation(_ url: URL?) {
        notifyListeners("navigation", data: ["url" : url?.absoluteString ?? ""])
    }
}
