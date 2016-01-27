//
//  SideBarViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 24.01.16.
//  Copyright © 2016 LightBlueFox. All rights reserved.
//

import Foundation

class SideBarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openContactUs(sender: AnyObject) {
    
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContactUsViewController") as! ContactUsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }

}