//
//  DiseaseViewController.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit
import Foundation

class DiseaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Declaring variables
    var selections : [Double] = []
    //Names of diseases
    var diseaseArray : [String] = []
    //Beta coefficients in a Cox model
    var Coefficients : [String] = []
    var lower : [String] = []
    var upper : [String] = []
    //Mean values of covariates in data set
    var ColMeans : [String] = []
    //Non parametric estimate of survival function at the mean value of covariates
    var BaseLineSurv : [String] = []
    var BaseLineLower : [String] = []
    var BaseLineUpper : [String] = []
    //Variables segue-d from ViewController
    var age: Double!
    var sex: Double!
    //UI elements
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
        var fileValues: [String]! = []
        fileValues = fileContents!.componentsSeparatedByString(",")
        fileValues[fileValues.count-1] = fileValues[fileValues.count-1].stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        return fileValues
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Reading in data
        lower = arrayFromContentsOfFileWithName("lower.txt")!
        upper = arrayFromContentsOfFileWithName("upper.txt")!
        Coefficients = arrayFromContentsOfFileWithName("coefficients.txt")!
        ColMeans = arrayFromContentsOfFileWithName("Means.txt")!
        diseaseArray = arrayFromContentsOfFileWithName("variables.txt")!
        
        //initializing user disease selections array
        selections = [Double](count: diseaseArray.count, repeatedValue: 0)
        
        BaseLineSurv = arrayFromContentsOfFileWithName("survBase.txt")!
        BaseLineLower = arrayFromContentsOfFileWithName("lowerBase.txt")!
        BaseLineUpper = arrayFromContentsOfFileWithName("upperBase.txt")!

        
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
        let epsilon: Double = pow(10,-5)
        cell.textLabel?.text = diseaseArray[indexPath.row]
        cell.accessoryType = (abs(selections[indexPath.row]-1) < epsilon) ? .Checkmark : .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < diseaseArray.count){
            selections[indexPath.row] = 1-selections[indexPath.row]
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    @IBAction func Calculate(sender: UIButton) {
        self.performSegueWithIdentifier("Calculate", sender: sender)
    }
    //function to calculate survival function from parameters in Cox model
    func predictSurv(baseLine: [Double], linearPredictor: Double) -> [Double]{
        var prediction = [Double](count: baseLine.count , repeatedValue: 0)
        for i in 0..<baseLine.count{
            prediction[i] = pow(baseLine[i],exp(linearPredictor))
        }
        return prediction
    }
    //convert wanted indices from Base arrays to Double
    func getBaseLine(baseArray: [String],indices: [Int]) -> [Double] {
        var outBase : [Double] = []
        for i in indices{
            outBase.append(Double(baseArray[i])!)
        }
        return outBase
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Perform calculations if button Calculate is pressed
        if segue.identifier == "Calculate" {
            var coefSum : Double = 0
            var lowerSum : Double = 0
            var upperSum : Double = 0
            var correctedCoef : Double = 0
            var Patient = [Double](count: 3 + selections.count, repeatedValue: 0)
            Patient = [2013, sex,age] + selections
            for i in 0..<Patient.count {
                correctedCoef = Patient[i]-Double(ColMeans[i])!
                coefSum += Double(Coefficients[i])!*correctedCoef
                lowerSum += Double(lower[i])!*correctedCoef
                upperSum += Double(upper[i])!*correctedCoef
            }
            
            let dest = segue.destinationViewController as! ResultsViewController
            dest.surv = predictSurv(getBaseLine(BaseLineSurv,indices: [364,1799]),linearPredictor: coefSum)
            dest.lower = predictSurv(getBaseLine(BaseLineLower,indices: [364,1799]),linearPredictor: lowerSum)
            dest.upper = predictSurv(getBaseLine(BaseLineUpper,indices: [364,1799]),linearPredictor: upperSum)

        }
    }
}