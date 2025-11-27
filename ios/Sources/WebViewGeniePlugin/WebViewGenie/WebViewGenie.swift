//
//  WebViewGenie.swift
//  App
//
//  Created by   TeamCity Agent on 25.11.2025.
//

import Foundation
import UIKit
import WebKit
import Capacitor

public class WebViewGenie: NSObject {
    
    private weak var plugin: WebViewGeniePlugin?
    private var webView: WKWebView?
    private var webViewController: UIViewController?
    private var isObserverAdded = false
    private var loadingIndicator: LoadingIndicator?
    
    public init(plugin: WebViewGeniePlugin) {
        self.plugin = plugin
        super.init()
    }
    
    deinit {
        removeObserver()
    }
    
    private func addObserver() {
        guard let webView = webView, !isObserverAdded else {
            return
        }
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        isObserverAdded = true
    }
    
    private func removeObserver() {
        guard let webView = webView, isObserverAdded else {
            return
        }
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.url))
        isObserverAdded = false
    }

    private func setupWebView(options: LoadingConfig) {
        if self.webViewController != nil && self.webView != nil {
            return
        }
        
        let viewController = UIViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.webViewController = viewController
        self.webView = WebViewBuilder.createWebView(in: viewController)
        
        webView?.navigationDelegate = self
        
        self.loadingIndicator = LoadingIndicator(view: viewController.view, config: options)

        addObserver()
    }
    
    public func openUrl(_ urlString: String, from viewController: UIViewController, call: CAPPluginCall, options: LoadingConfig) {
        self.closeWebView()
        self.setupWebView(options: options)
        
        guard let url = URL(string: urlString) else {
            call.reject("Invalid URL")
            return
        }
        
        guard let webViewController = self.webViewController else {
            call.reject("Unable to get web view controller")
            return
        }
        
        self.loadingIndicator?.show()
        
        
        let request = URLRequest(url: url)
        self.webView?.load(request)

        viewController.present(webViewController, animated: true, completion: nil)
        

        call.resolve()
    }
    
    public func closeWebView() {
        guard let webViewController = webViewController else {
            return
        }
        
        if let webView = webView {
            removeObserver()
            webView.stopLoading()
        }
        
        webViewController.dismiss(animated: true)
        
        self.loadingIndicator?.hide()
        
        self.webView = nil
        self.webViewController = nil
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url), let newURL = change?[.newKey] as? URL {
            plugin?.navigation(newURL)
        }
    }
}

extension WebViewGenie: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator?.hide()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator?.hide()
    }
}
