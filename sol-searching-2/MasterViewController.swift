//
//  MasterViewController.swift
//  sol-searching-2
//
//  Created by Daniel Lee on 4/28/20.
//  Copyright © 2020 dlee100. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var solObjArray = [SolInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets data from the rest end point
        getRestAPIData()
        
    
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
        if let indexPath = tableView.indexPathForSelectedRow {
            
                 let selectedSolObj = solObjArray[indexPath.row]
               
                 let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
             
                 controller.detailViewSolObj = selectedSolObj
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return solObjArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let selectedSolObj = solObjArray[indexPath.row]
        cell.textLabel!.text = selectedSolObj.ObjectName
        cell.imageView?.image = extractImage(named: selectedSolObj.ObjectImageName)
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: Custom Functions
    func extractImage(named:String) -> UIImage {
        let uri = URL(string: named)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        return img!
    }
    
    func getRestAPIData(){
        // Raw JSON file from github
        let endPoint:String = "https://raw.githubusercontent.com/dlee100/JSON-Sol-Searching/master/db.json"
        
        let jsURL:URL = URL(string: endPoint)!
       
        // 2. call rest end point
        let jsonData = try? Data (contentsOf: jsURL)
        print(jsonData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        
        if (jsonData != nil) {
        
        //3. Receive the Incoming Data (JSON). In a Local Dictionary object
        let dictionary:NSDictionary =
            (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        print(dictionary)
            
            let solDictionary = dictionary["Object"]! as! [[String:AnyObject]]
        
            // 4. Convert Dictionary Object to Individual Sol Object
                
        for index in 0...solDictionary.count - 1 {
            let singleSol  = solDictionary[index]
            let sol = SolInfo()
        
            sol.ObjectName = singleSol["ObjectName"] as! String
            sol.ObjectID = singleSol["ObjectID"] as! Int
            sol.ObjectImageName = singleSol["ObjectImageName"] as! String
            sol.ObjectAU = singleSol["ObjectAU"] as! Double
            sol.ObjectYear = singleSol["ObjectYear"] as! Int
            sol.ObjectSite = singleSol["ObjectSite"] as! String
            sol.ObjectSymbol = singleSol["ObjectSymbol"] as! String
            sol.ObjectReference = singleSol["ObjectReference"] as! String
            sol.ObjectDescription = singleSol["ObjectDescription"] as! String
            
            // 5. Append it to the Array
            solObjArray.append(sol)
            
         
    }

            
            
            
        }
        
    }
}

