//
//  RefDetailController.swift
//  sol-searching-2
//
//  Created by Daniel Lee on 4/28/20.
//  Copyright © 2020 dlee100. All rights reserved.
//

import Foundation
import UIKit
class SubDetailController : UIViewController {
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            nameSol.text = refDetailSolObj.ObjectName
        }
        
        var refDetailSolObj: SolInfo = SolInfo()
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showBrowserDetail") {
            // find the controller the segue is conencted to
            let controller = segue.destination as! BrowserDetailController
               // pass the selected Hiking Trail to the controller
            controller.browserSolObj = refDetailSolObj
            
        }
        
    }
    }
