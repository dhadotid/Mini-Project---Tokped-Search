//
//  DetailViewController.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 19/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var product: Product!
    
    deinit {
        print("Deinit \(type(of: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Detail"
        embeddedWebView.backgroundColor = .white
        embeddedWebView.isOpaque = false
//        embeddedWebView.navigationDelegate = self
        loadContent()
    }
    
    func loadContent() {
//        guard let url = URL(string: ) else {
//                print("Invalid embedded url \(String(describing: product.uri))")
//                return
//        }
        embeddedWebView.load(URLRequest(url: product.uri!))
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
////        navigationAction.request.url
//        decisionHandler(.allow)
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @IBOutlet weak var embeddedWebView: WKWebView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
