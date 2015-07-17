//
//  VacancyFeedTableViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 14.06.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class VacancyFeedTableViewController: UITableViewController {

    @IBOutlet var vacancyFeedView: UITableView!
    var itemsReceiver = NewsAndVacanciesReceiver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Получение всех вакансий
        
        itemsReceiver.getAllVacancies();
        
        self.navigationItem.title = "ВАКАНСИИ"
        self.navigationController?.navigationBar.translucent = false;
        
        self.vacancyFeedView.rowHeight = 80
    }

    override func viewWillAppear(animated: Bool) {
        vacancyFeedView.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
      //  return 0
    //}

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //println(itemsReceiver.newsStack.count);
        return itemsReceiver.vacStack.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as NewsCellViewController
        let cell = self.vacancyFeedView.dequeueReusableCellWithIdentifier("VacancyCell") as VacancyCellViewController
        // Configure the cell...
        let currentVac = itemsReceiver.vacStack[indexPath.row];
        
        cell.cellVacTitle?.text = currentVac.title;
        cell.cellVacDate?.text = currentVac.createdDate;
        cell.cellVacAnnounceImage?.image = currentVac.announceImage;
        switch currentVac.gender {
        case 0 : cell.cellVacFemaleImage?.image = UIImage(named: "femaleRed"); cell.cellVacMaleImage?.image = UIImage(named: "maleGray");
        case 1 : cell.cellVacFemaleImage?.image = UIImage(named: "femaleGray"); cell.cellVacMaleImage?.image = UIImage(named: "maleRed");
        case 2 : cell.cellVacFemaleImage?.image = UIImage(named: "femaleRed"); cell.cellVacMaleImage?.image = UIImage(named: "maleRed");
        default : cell.cellVacFemaleImage?.image = UIImage(named: "femaleRed"); cell.cellVacMaleImage?.image = UIImage(named: "maleRed");
        }
        cell.cellVacAnnouncement?.text = currentVac.announcement;
        cell.cellVacMoney?.text = currentVac.rate;
        return cell
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        var vacancyViewController = segue.destinationViewController as VacancyViewController
        // Pass the selected object to the new view controller.
        let cell = sender as VacancyCellViewController
        
        var indexPath = self.vacancyFeedView.indexPathForCell(cell)
        let currentVac = self.itemsReceiver.vacStack[indexPath!.row]
        vacancyViewController.fullTextImage = currentVac.fullTextImage
        vacancyViewController.heading = currentVac.title
        vacancyViewController.announcement = currentVac.announcement
        vacancyViewController.createdDate = currentVac.createdDate
        vacancyViewController.rate = currentVac.rate
        vacancyViewController.fullText = currentVac.fullText
        switch currentVac.gender {
        case 0 : vacancyViewController.femaleImg = UIImage(named: "femaleRed"); vacancyViewController.maleImg = UIImage(named: "maleGray");
        case 1 : vacancyViewController.femaleImg = UIImage(named: "femaleGray"); vacancyViewController.maleImg = UIImage(named: "maleRed");
        case 2 : vacancyViewController.femaleImg = UIImage(named: "femaleRed"); vacancyViewController.maleImg = UIImage(named: "maleRed");
        default : vacancyViewController.femaleImg = UIImage(named: "femaleRed"); vacancyViewController.maleImg = UIImage(named: "maleRed");
        }
    }
    

}
