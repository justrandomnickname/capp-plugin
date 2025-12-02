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
        
        let toolbar = self.setupToolbar(webview: webView, webViewController: viewController)
        self.setupConstraints(webview: webView, webViewController: viewController, toolbar: toolbar)
        
        return webView
    }


    private static func setupToolbar(webview: WKWebView, webViewController: UIViewController) -> UIToolbar {
        let toolbar = UIToolbar()
        webViewController.view.addSubview(toolbar)

        configureAppearance(for: toolbar)
        layoutToolbar(toolbar, in: webViewController.view)
        toolbar.items = createToolbarItems(webview: webview, viewController: webViewController)

        return toolbar
    }
    
    private static func configureAppearance(for toolbar: UIToolbar) {
        if #available(iOS 13.0, *) {
            let appearance = UIToolbarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            toolbar.standardAppearance = appearance
            
            if #available(iOS 15.0, *) {
                toolbar.scrollEdgeAppearance = appearance
            }
            
            toolbar.tintColor = .label
        } else {
            toolbar.barStyle = .default
            toolbar.isTranslucent = false
        }
    }
    
    private static func layoutToolbar(_ toolbar: UIToolbar, in view: UIView) {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private static func createToolbarItems(webview: WKWebView, viewController: UIViewController) -> [UIBarButtonItem] {
        let closeTitle = Bundle(identifier: "com.apple.UIKit")?.localizedString(forKey: "Done", value: "Close", table: nil) ?? "Close"
        let closeButton = CloseButton(title: closeTitle, viewController: viewController)

        let backIcon = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backIcon, style: .plain, target: webview, action: #selector(webview.goBack))
        
        let fwdIcon = UIImage(systemName: "chevron.right")
        let forwardButton = UIBarButtonItem(image: fwdIcon, style: .plain, target: webview, action: #selector(webview.goForward))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 40

        return [closeButton, flexSpace, backButton, fixedSpace, forwardButton]
    }
    
    
    private static func setupConstraints(webview: WKWebView, webViewController: UIViewController, toolbar: UIToolbar) {
        webview.translatesAutoresizingMaskIntoConstraints = false

//        let guide = webViewController.view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            webview.leadingAnchor.constraint(equalTo: webViewController.view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: webViewController.view.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: webViewController.view.bottomAnchor),
        ])
    }
}



class CloseButton: UIBarButtonItem {
    weak var viewController: UIViewController?

    init(title: String, viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        self.title = title
        self.style = .done
        self.target = self
        self.action = #selector(performClose)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func performClose() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
