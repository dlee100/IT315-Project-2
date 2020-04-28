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
        
        /*
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        } */
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
            
                 let selectedHikingTrail = solObjArray[indexPath.row]
               
                 let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
             
                 controller.detailViewSolObj = selectedObj
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
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

    func getRestAPIData(){
        // Know the end Point.
        let endPoint:String = "http://www.protogic.com/universityservice/service.svc/AllHikingTrails"
        
        let jsURL:URL = URL(string: endPoint)!
       
        // 2. Call the Rest End point. by using the Data function
        let jsonData = try? Data (contentsOf: jsURL)
        print(jsonData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        
        if (jsonData != nil) {
        
        //3. Receive the Incoming Data (JSON). In a Local Dictionary object
        let dictionary:NSDictionary =
            (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        print(dictionary)
            
            let solDictionary = dictionary["SolInfo"]! as! [[String:AnyObject]]
        
            // 4. Convert Dictionary Object to Individual Hiking Trail Object
                
        for index in 0...solDictionary.count - 1 {
            let singleSol  = solDictionary[index]
            let sol = SolInfo()
        
            sol.ObjectName = singleSol["ObjectName"] as! String
            sol.ObjectImageName = singleSol["ObjectImageName"] as! String
            sol.ObjectAU = singleSol["ObjectAU"] as! Double
            sol.ObjectYear = singleSol["ObjectYear"] as! Int
            sol.ObjectSite = singleSol["ObjectSite"] as! String
            sol.ObjectSymbol = singleSol["ObjectSymbol"] as! String
            sol.ObjectReference = singleSol["ObjectReference"] as! String
            sol.ObjectDescription = singleSol["ObjectDescription"] as! String
            
            // 5. Append it to the Array
            solObjArray.append(sol)
            
            /*
            ht.TrailName = singleHT["TrailName"] as! String
            ht.TrailAltitude  = singleHT["TrailElevation"] as! String
            ht.TrailImageName  = singleHT["TrailImage"] as! String
        
            ht.TrailDescription = ""
            ht.TrailDifficulty = singleHT["TrailDifficulty"] as! String
            ht.TrailFavorite = false
            ht.TrailID = singleHT["TrailID"] as! Int
            ht.TrailSite = singleHT["TrailWebsite"] as! String
            ht.TrailTime = singleHT["TrailTime"] as! String
        
            // 5 Append it to the Array
            hikingTrailArray.append(ht) */
    }

            
            
            
        }
        
    }
}

