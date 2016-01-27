//
//  NewsCellViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 20.06.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class NewsCellViewController: UITableViewCell {

    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellAnnounce: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
