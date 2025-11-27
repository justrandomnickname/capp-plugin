//
//  WebViewBuilder.swift
//  App
//
//  Created by   TeamCity Agent on 26.11.2025.
//

import Foundation
import UIKit
import WebKit


public class WebViewBuilder {
    static func createWebView(in viewController: UIViewController) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        
        webView.configuration.suppressesIncrementalRendering = false
        webView.configuration.websiteDataStore = WKWebsiteDataStore.default()
        webView.scrollView.isScrollEnabled = true
        viewController.view.addSubview(webView)
        
        self.setupConstraints(webview: webView, webViewController: viewController)
        
        return webView
    }
    
    
    private static func setupConstraints(webview: WKWebView, webViewController: UIViewController) {

        webview.translatesAutoresizingMaskIntoConstraints = false

        let guide = webViewController.view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: guide.topAnchor),
            webview.leadingAnchor.constraint(equalTo: webViewController.view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: webViewController.view.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
}
