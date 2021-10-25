//
//  WebView.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    let targetUrlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: targetUrlString)!))
    }
}
