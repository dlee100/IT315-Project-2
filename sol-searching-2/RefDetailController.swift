//
//  RefDetailController.swift
//  sol-searching-2
//
//  Created by Daniel Lee on 4/28/20.
//  Copyright © 2020 dlee100. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class RefDetailController: UIViewController {
    
    @IBOutlet weak var webBrowser: WKWebView!
    
    @IBOutlet weak var nameSol: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loadWebContent()
            nameSol.text = refDetailSolObj.ObjectName
        }
        
        
        func loadWebContent() {
           
            let myURL = URL(string:refDetailSolObj.ObjectSite)
              let myRequest = URLRequest(url: myURL!)
              webBrowser.load(myRequest)
            
        }
        var refDetailSolObj: SolInfo = SolInfo()
        
    }
