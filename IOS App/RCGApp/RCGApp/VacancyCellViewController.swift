//
//  VacancyCellViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 11.07.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class VacancyCellViewController: UITableViewCell {

    @IBOutlet weak var cellVacAnnounceImage: UIImageView!
    @IBOutlet weak var cellVacFemaleImage: UIImageView!
    @IBOutlet weak var cellVacMaleImage: UIImageView!
    @IBOutlet weak var cellVacDate: UILabel!
    @IBOutlet weak var cellVacTitle: UILabel!
    @IBOutlet weak var cellVacAnnouncement: UILabel!
    @IBOutlet weak var cellVacMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
