//
//  VacancyViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class VacancyViewController: UIViewController {

    var fullTextImage: UIImage!
    var maleImg: UIImage!
    var femaleImg: UIImage!
    var createdDate: String?
    var heading: String?
    var announcement: String?
    var fullText: String?
    var rate: String?
    
    @IBOutlet weak var vacancyScrollView: UIScrollView!
    
    @IBAction func vacancyRespondButton(sender: AnyObject) {
    }
    @IBOutlet weak var vacancyFullTextImage: UIImageView!
    @IBOutlet weak var vacancyMaleImg: UIImageView!
    @IBOutlet weak var vacancyFemaleImg: UIImageView!
    @IBOutlet weak var vacancyCreatedDate: UILabel!
    @IBOutlet weak var vacancyTitle: UILabel!
    @IBOutlet weak var vacancyAnnouncement: UILabel!
    @IBOutlet weak var vacancyRate: UILabel!
    @IBOutlet weak var vacancyFullText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ВАКАНСИЯ"
        let buttonBack: UIButton = UIButton.buttonWithType(.Custom) as UIButton;
        buttonBack.frame = CGRectMake(0, 0, 40, 40);
        buttonBack.setImage(UIImage(named: "backButton"), forState: .Normal);
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside);
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack);
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false);
        
        vacancyTitle.text = heading!
        vacancyAnnouncement.text = announcement!
        vacancyFullTextImage.image = fullTextImage.rounded;
        vacancyMaleImg.image = maleImg;
        vacancyFemaleImg.image = femaleImg;
        vacancyCreatedDate.text = createdDate;
        vacancyRate.text = rate;
        vacancyFullText.text = fullText;
        
        
    
    }
    func leftNavButtonClick(sender: UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true)
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
