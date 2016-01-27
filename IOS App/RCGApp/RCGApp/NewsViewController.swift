//
//  SecondViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var imageURL: String?
    var createdDate: String?
    var heading: String?
    var announcement: String?
    var fullText: String?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsCreatedDate: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAnnouncement: UILabel!
    @IBOutlet weak var newsFullText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newsTitle.text = heading!
        newsAnnouncement.text = announcement!;
        newsFullText.text = fullText!;
        if (imageURL != nil) || (imageURL != "")
        {
            newsImage.sd_setImageWithURL(NSURL(string: imageURL!))
            newsImage.layer.cornerRadius = 5.0
            newsImage.layer.masksToBounds = true
        }
        else
        {
            newsImage.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
    
        
        
        newsCreatedDate.text = createdDate!;
        
        self.navigationItem.title = "НОВОСТЬ"
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        
        let buttonBack: UIButton = UIButton(type: .Custom);
        buttonBack.frame = CGRectMake(0, 0, 40, 40);
        buttonBack.setImage(UIImage(named: "backButton"), forState: .Normal);
        buttonBack.setImage(UIImage(named: "backButtonSelected"), forState: UIControlState.Highlighted)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside);
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack);
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false);
        
        //Добавляем кнопку для вызоа sideBar
        
        let revealViewController = self.revealViewController() as SWRevealViewController
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.navigationController?.navigationBarHidden = false;
        
        let revealButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem(rawValue: 15)!, target: revealViewController, action: Selector("rightRevealToggle:"))
        revealButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = revealButton
        //
        
        
        //self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton");
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    }
    func leftNavButtonClick(sender: UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

