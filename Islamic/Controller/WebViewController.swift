//
//  WebViewController.swift
//  Muslim UZ
//
//  Created by Asliddin Rasulov on 15/10/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "fajr", withExtension: "html")
        webView.loadFileURL(url!, allowingReadAccessTo: url!)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
