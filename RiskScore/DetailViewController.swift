//
//  DetailViewController.swift
//  RiskScore
//
//  Created by BolloMini on 27.6.2016.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var assia1 = ""
    
    @IBOutlet weak var assia: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assia.text = assia1
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
