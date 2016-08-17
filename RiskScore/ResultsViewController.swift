//
//  ResultsViewController.swift
//  RiskScore
//
//  Created by BolloMini on 21.6.2016.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var surv : [Double]!
    var lower : [Double]!
    var upper : [Double]!
    
    @IBOutlet weak var oneYearSurvLab : UILabel!
    @IBOutlet weak var fiveYearSurvLab : UILabel!
    
    @IBOutlet weak var oneYearView: UIView!
    @IBOutlet weak var fiveYearView: UIView!
    
    var oneYearSegue : Bool!
    
    func tapped(sender : UIView) {
        self.performSegueWithIdentifier("detailSegue", sender: sender)
    }
    
    
    func viewColor(surv : Double, risks : [Double]) -> UIColor {
        var color : UIColor!
        
        switch surv {
        case let x where x < risks[0]:
            color = UIColor.redColor()
            break
        case let x where x > risks[0] && x < risks[1]:
            color = UIColor.yellowColor()
            break
        case let x where x > risks[1]:
            color = UIColor.greenColor()
            break
        default:
            break
        }
        
        return color
    }
    
    /*func survLabel(label: UILabel){
     
        return label
    }*/
    func survView(label: UILabel,View : UIView,surv : Double, borderColor : UIColor,risks : [Double]){
        label.text = String(round(surv*1000)/10) + "%"
        View.backgroundColor = viewColor(surv, risks: risks)
        View.layer.borderColor = borderColor.CGColor
        View.layer.borderWidth = 1.0
        
        let Tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        View.addGestureRecognizer(Tap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        survView(oneYearSurvLab,View : oneYearView,surv : surv[0],borderColor : purpleColor,risks : [0.33,0.66])
        survView(fiveYearSurvLab,View : fiveYearView,surv : surv[1],borderColor : purpleColor,risks : [0.2,0.5])
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            let dest = segue.destinationViewController as! DetailViewController
            
            if sender as! UIGestureRecognizer == oneYearView.gestureRecognizers![0] {
                dest.assia1 = oneYearSurvLab.text!
            } else {
                dest.assia1 = fiveYearSurvLab.text!
            }
        }
    }
}