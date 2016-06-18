//
//  Disease.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class Disease: NSObject {
    var diseaseName : String = ""
    var diseaseSelected : Bool = false
    
    func initWithDiseaseName(name : String, selected : Bool) -> Disease {
        diseaseName = name
        diseaseSelected = selected
        
        return self
    }
}
