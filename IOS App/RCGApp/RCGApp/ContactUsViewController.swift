//
//  ContactUsViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1);
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1);

        let navBarFont = UIFont(name: "Roboto-Regular", size: 17.0) ?? UIFont.systemFontOfSize(17);

        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navBarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.title = "ОБРАТНАЯ СВЯЗЬ"
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
