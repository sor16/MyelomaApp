//
//  ViewController.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

var purpleColor : UIColor = UIColor(red: 126/255, green: 67/255, blue: 1, alpha: 1)

class ViewController: UIViewController{
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
    var testTxt: [String] = []
    //var Patient: [Int] = (count: , repeatedValue: 0)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
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
    
    @IBAction func Advance(sender: AnyObject) {
        if age.text == "" {
            let alertController = UIAlertController(title: "Not allowed", message: "Please enter your age.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in }
            alertController.addAction(cancelAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
            alertController.view.tintColor = UIColor(red: 126/255, green: 67/255, blue: 1, alpha: 1)
        } else {
            self.performSegueWithIdentifier("Advance", sender: sender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Advance" {
            let dest = segue.destinationViewController as! DiseaseViewController

            dest.age = Double(age.text!)
            dest.sex = Double(sex.selectedSegmentIndex)
            
            //dest.results = Results().initWithAge(Int(age.text!)!, sex: Sex(rawValue: sex.selectedSegmentIndex + 1)!, diseases: [])

        }
    }
}

