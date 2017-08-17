//
//  WebViewController.swift
//  VideoQuickStart
//
//  Created by Annunziato, Jose on 5/28/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import Foundation
import UIKit

class WebViewController : UIViewController, UIWebViewDelegate {
    
    @IBAction func videoChatBtn(_ sender: Any) {
        performSegue(withIdentifier: "video", sender: nil)
    }
    @IBOutlet weak var webView: UIWebView!
    
    var targetRoom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://speak-app-dev.herokuapp.com")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        webView.scrollView.isScrollEnabled = true
        webView.scalesPageToFit = false
        webView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print("link clicked")
        
        if(request.url?.scheme == "speakapp") {
            let url: String = (request.url?.absoluteString)!
            
            let destination = getQueryStringParameter(url: url, param: "destination")!
            targetRoom = getQueryStringParameter(url: url, param: "room")!
            
            if(destination == "view1") {
                performSegue(withIdentifier: "view1", sender: nil)
            } else if(destination == "view2") {
                performSegue(withIdentifier: "view2", sender: nil)
            } else if(destination == "call") {
                performSegue(withIdentifier: "call", sender: nil)
            } else {
                performSegue(withIdentifier: "video", sender: nil)
            }
            
            return false
        }
        
        if(navigationType == UIWebViewNavigationType.linkClicked) {
            
            let url: String = (request.url?.absoluteString)!

            let destination = getQueryStringParameter(url: url, param: "destination")!
            targetRoom = getQueryStringParameter(url: url, param: "room")!
            
            if(destination == "view1") {
                performSegue(withIdentifier: "view1", sender: nil)
            } else if(destination == "view2") {
                performSegue(withIdentifier: "view2", sender: nil)
            } else if(destination == "call") {
                performSegue(withIdentifier: "call", sender: nil)
            } else {
                performSegue(withIdentifier: "video", sender: nil)
            }
            
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "call") {
            let destination:ViewController = segue.destination as! ViewController
            destination.targetRoom = targetRoom
        }
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
