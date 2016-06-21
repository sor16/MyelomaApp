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
    var Coefficients : [Double] = []
    var ColMeans : [Double] = []
    var BaseLine : [Double] = []
    var results : Results!
    
    var txtFileVar : [String] = []
    var txtFileCoef : [String] = []
    var txtFileMeans : [String] = []
    var txtFileBaseLine : [String]=[]
    
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
    // Assia
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        //
        txtFileVar = arrayFromContentsOfFileWithName("variables.txt")!
        
        for i in 0..<txtFileVar.count {
            txtFileVar[i] = txtFileVar[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            diseaseArray.append(Disease().initWithDiseaseName(txtFileVar[i], selected: false))
        }
        
        txtFileCoef = arrayFromContentsOfFileWithName("coefficients.txt")!
        txtFileMeans = arrayFromContentsOfFileWithName("Means.txt")!
        
        for i in 0..<txtFileCoef.count{
            txtFileCoef[i] = txtFileCoef[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            Coefficients.append(Double(txtFileCoef[i])!)
            txtFileMeans[i] = txtFileMeans[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            ColMeans.append(Double(txtFileMeans[i])!)
        }
        txtFileBaseLine = arrayFromContentsOfFileWithName("baseline.txt")!
        for i in 0..<txtFileBaseLine.count{
            txtFileBaseLine[i] = txtFileBaseLine[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            BaseLine.append(Double(txtFileBaseLine[i])!)
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
            
            var modelArray : [Int] = [2013, results.sex.rawValue,results.age]
            
            for disease in diseaseArray {
                modelArray.append(Int(disease.diseaseSelected))
            }
            var coefSum : Double = 0
            for i in 0..<modelArray.count {
                coefSum += Coefficients[i]*(Double(modelArray[i])-ColMeans[i])
            }
            print(exp(-BaseLine[364]*exp(coefSum)))
            print(exp(-BaseLine[365*5-1]*exp(coefSum)))
            let dest = segue.destinationViewController as! ResultsViewController
            //dest.oneYearSurv = String(exp(BaseLine[364]*exp(coefSum)))
            //dest.fiveYearSurv = String(exp(-BaseLine[365*5-1]*exp(coefSum)))
        }
    }
    
}