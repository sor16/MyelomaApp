//
//  ResultsViewController.swift
//  RiskScore
//
//  Created by BolloMini on 21.6.2016.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var oneYearSurv : Double!
    var fiveYearSurv : Double!
    
    @IBOutlet weak var oneYearSurvLab : UILabel!
    @IBOutlet weak var fiveYearSurvLab : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneYearSurvLab.text = String(round(oneYearSurv*1000)/10) + "%"
        fiveYearSurvLab.text = String(round(fiveYearSurv*1000)/10) + "%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}