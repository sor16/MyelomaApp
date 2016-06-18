//
//  ViewController.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var age: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    @IBAction func Advance(sender: AnyObject) {
        if age.text == "" {
            let alertController = UIAlertController(title: "Not Possible", message: "Age not entered.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "K", style: .Cancel) { (action) in }
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
            
            dest.results = Results().initWithAge(Int(age.text!)!, sex: Sex(rawValue: sex.selectedSegmentIndex + 1)!, diseases: [])
        }
    }
}

