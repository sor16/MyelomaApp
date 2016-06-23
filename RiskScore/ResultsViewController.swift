//
//  ResultsViewController.swift
//  RiskScore
//
//  Created by BolloMini on 21.6.2016.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var oneYearSurvLab : UILabel!
//    @IBOutlet weak var fiveYearSurvLab : UILabel!
    var oneYearSurv : Double!
    //var fiveYearSurv : Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        oneYearSurvLab.text = String(oneYearSurv)
        //fiveYearSurvLab.text = String(fiveYearSurv)
        // Do any additional setup after loading the view.
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
