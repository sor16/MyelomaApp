//
//  DiseaseCell.swift
//  RiskScore
//
//  Created by Sölvi Rögnvaldsson on 13/06/16.
//  Copyright © 2016 Sölvi Rögnvaldsson. All rights reserved.
//

import UIKit

class DiseaseCell: UITableViewCell {
    
    @IBOutlet weak var diseaseName: UILabel!
    @IBOutlet weak var diseaseSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
