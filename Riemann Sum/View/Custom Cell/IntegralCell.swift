//
//  IntegralCell.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class IntegralCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var upperBoundLabel: UILabel!
    @IBOutlet weak var lowerBoundLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
