//
//  DailyTableViewCell.swift
//  Tensorswift
//
//  Created by Bryan Marks on 5/1/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    @IBOutlet weak var dailyFoodCalsText: UILabel!

    @IBOutlet weak var dailyNameFoodText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
