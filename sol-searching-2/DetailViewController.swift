//
//  DetailViewController.swift
//  sol-searching-2
//
//  Created by Daniel Lee on 4/28/20.
//  Copyright © 2020 dlee100. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameSol: UILabel!
    @IBOutlet weak var imgSol: UIImageView!
    @IBOutlet weak var descSol: UILabel!
    @IBOutlet weak var auSol: UILabel!
    @IBOutlet weak var yearSol: UILabel!
    
    @IBAction func referencesSol(_ sender: UIButton) {
        
    }
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        detailDescriptionLabel.text = detailViewSolObj.ObjectName
        nameSol.text = detailViewSolObj.ObjectName
        imgSol.image = extractImage(named: detailViewSolObj.ObjectImageName)
        descSol.text = detailViewSolObj.ObjectDescription
        auSol.text = "AU: \(String(detailViewSolObj.ObjectAU))"
        yearSol.text = "Year: \(String(detailViewSolObj.ObjectYear)) Earth days"
        
    }
    
    // MARK: Custom Functions
    func extractImage(named:String) -> UIImage {
        let uri = URL(string: named)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        return img!
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    //var detailViewSolObj:SolInfo?
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showRefDetail") {
            // find the controller the segue is conencted to
            let controller = segue.destination as! RefDetailController
               // pass the selected Hiking Trail to the controller
            controller.refDetailSolObj = detailViewSolObj!
            
        }
        
    } */
    
    var detailViewSolObj: SolInfo = SolInfo()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "showRefDetail") {
        // find the controller the segue is conencted to
        let controller = segue.destination as! RefDetailController
           // pass the selected Hiking Trail to the controller
        controller.refDetailSolObj = detailViewSolObj
        
    }
}

}
