//
//  WebView.swift
//  QRCode
//
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 hand. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var url : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = url! as String
        
        let path = URL(string: str)
        let webview = UIWebView(frame: self.view.bounds)
        webview.delegate = self
        webview.loadRequest(URLRequest(url: path!))
        self.view.addSubview(webview)
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
}
