//
//  Results.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 15/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

enum Sex : Int {
    case Male = 1, Female
}

class Results: NSObject {
    var age : Int = 0
    var sex : Sex!
    var diseases : [Disease] = []
    
    func initWithAge(age : Int, sex : Sex, diseases : [Disease]) -> Results! {
        self.age = age
        self.sex = sex
        self.diseases = diseases
        
        return self
    }

}
