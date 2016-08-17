//
//  Patient.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 27/07/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import Foundation
import UIKit

class Patient: NSObject {
    var age : Int = 0
    var sex : Sex!
    var diseases : [Bool] = []
    
    func initPatient(age : Int, sex : Sex, diseases : [Bool]) -> Patient! {
        self.age = age
        self.sex = sex
        self.diseases = diseases
        
        return self
    }
    
}
