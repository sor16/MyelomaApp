//
//  DiseaseViewController.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class DiseaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Declaring variables
    
    var diseaseArray : [Disease] = []
    var results : Results!
    
    var txtFile : [String] = []
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var Scroller: UIScrollView!
    @IBOutlet weak var SubmitButton: UIButton!
    
    // MARK: View Setup Functions
    
    //Function for reading in txt file
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        if path == nil {
            return nil
        }
        
        var fileContents: String? = nil
        do {
            fileContents = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        } catch _ as NSError {
            return nil
        }
        
        return fileContents!.componentsSeparatedByString("\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        txtFile = arrayFromContentsOfFileWithName("variables.txt")!
        for i in 0..<txtFile.count {
            txtFile[i] = txtFile[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            diseaseArray.append(Disease().initWithDiseaseName(txtFile[i], selected: false))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Setup
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.row >= diseaseArray.count) ? 80 : 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseaseArray.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row >= diseaseArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! ButtonCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("diseaseCell")! as UITableViewCell
        
        cell.textLabel?.text = diseaseArray[indexPath.row].diseaseName
        cell.accessoryType = (diseaseArray[indexPath.row].diseaseSelected) ? .Checkmark : .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        diseaseArray[indexPath.row].diseaseSelected = !diseaseArray[indexPath.row].diseaseSelected
        
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    @IBAction func Calculate(sender: UIButton) {
        results.diseases = diseaseArray
        self.performSegueWithIdentifier("Calculate", sender: sender)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier == "Calculate" {
            // Calculate info...
            
            var modelArray : [Int] = [2013,results.age, results.sex.rawValue]
            
            for disease in diseaseArray {
                modelArray.append(Int(disease.diseaseSelected))
            }
            
            print(modelArray)
        }
    }
    
}
