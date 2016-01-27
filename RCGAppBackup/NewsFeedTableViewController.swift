//
//  NewsFeedTableViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 01.06.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class NewsFeedTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var newsFeedTableView: UITableView!
    var itemsReceiver = NewsAndVacanciesReceiver()
    //var refreshControll: UIRefreshControl!;
    
//TODO: сделать иконки текущего таба при инициализации
//    required init(coder aDecoder: NSCoder!) {
//        super.init(coder: aDecoder)
//        self.tabBarItem.image = UIImage(named:"NewsFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
//                self.tabBarItem.selectedImage = UIImage(named:"NewsFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Описываем пул-ту-рефреш
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Потяните вниз, чтобы обновить");
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //self.tableView.addSubview(self.refreshControl!);
        
        //Убираем прозрачность таббара и навбара
        self.navigationItem.title = "НОВОСТИ";
        self.navigationController?.navigationBar.translucent = false;
        self.tabBarController?.tabBar.translucent = false;
        
        //Задаем иконки в таббаре. Получилось только так, т.к. через сториборд unselected иконки становятся серыми
        //TODO: Сделать нормально (возможно через init(coder:)
        let tabBar = self.tabBarController?.tabBar;
        
        tabBar?.tintColor = UIColor.whiteColor();
        let tabItems = tabBar?.items;
        let tabItem0 = tabItems![0] ;
        tabItem0.image = UIImage(named:"news")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem0.selectedImage = UIImage(named:"newsSelected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        let tabItem1 = tabItems![1] ;
        tabItem1.image = UIImage(named:"vacancy")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem1.selectedImage = UIImage(named:"vacancySelected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        let tabItem2 = tabItems![2] ;
        tabItem2.image = UIImage(named:"feedback")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem2.selectedImage = UIImage(named:"feedbackSelected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        //
        self.newsFeedTableView.rowHeight = 80;
        
        //MARK: используя MBProgressHUD делаем экран загрузки, пока подгружаются новости
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        //loadingNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
        loadingNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
        loadingNotification.labelText = "Загрузка"
        
        
        self.itemsReceiver.getAllNews({(success: Bool, result: String) in
            if success {
                loadingNotification.hide(true)
                self.newsFeedTableView.reloadData()
            }
            else if !success
            {
                loadingNotification.hide(true)
                
                let failureNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                failureNotification.mode = MBProgressHUDMode.Text
                failureNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                //failureNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
                failureNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
                failureNotification.labelText = "Ошибка"
                failureNotification.detailsLabelText = result
                failureNotification.hide(true, afterDelay: 3)
                self.newsFeedTableView.reloadData()
            }
        })


        
    }
    func refresh(sender:AnyObject) {
        //MARK: используя MBProgressHUD делаем экран загрузки, пока подгружаются новости
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);
        //loadingNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
        loadingNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
        loadingNotification.labelText = "Загрузка"
        self.itemsReceiver.getAllNews({(success: Bool, result: String) in
            if success {
                loadingNotification.hide(true)
                self.newsFeedTableView.reloadData()
            }
            else if !success
            {
                loadingNotification.hide(true)
                
                let failureNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                failureNotification.mode = MBProgressHUDMode.Text
                failureNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                //failureNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
                failureNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
                failureNotification.labelText = "Ошибка"
                failureNotification.detailsLabelText = result
                failureNotification.hide(true, afterDelay: 3)
                self.newsFeedTableView.reloadData()
            }
        })
        newsFeedTableView.reloadData();
        self.refreshControl?.endRefreshing();
    }
    override func viewWillAppear(animated: Bool) {
        newsFeedTableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
    //    return 0
    //}
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //println(itemsReceiver.newsStack.count);
        return itemsReceiver.newsStack.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as NewsCellViewController
        let cell = self.newsFeedTableView.dequeueReusableCellWithIdentifier("NewsCell") as! NewsCellViewController
        // Configure the cell...
        let currentNews = itemsReceiver.newsStack[indexPath.row];
        
        cell.cellTitle?.text = currentNews.title
        cell.cellAnnounce?.text = currentNews.announcement;
        cell.cellDate?.text = currentNews.createdDate;
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //TODO:
        // Get the new view controller using [segue destinationViewController].
        let newsViewController =  segue.destinationViewController as! NewsViewController
        //sender is a tapped NewsCellViewController
        let cell = sender as! NewsCellViewController
        
        let indexPath = self.newsFeedTableView.indexPathForCell(cell);
        
        let currentNews = self.itemsReceiver.newsStack[indexPath!.row];
        newsViewController.heading = currentNews.title;
        newsViewController.announcement = currentNews.announcement;
        newsViewController.fullText = currentNews.fullText;
        newsViewController.createdDate = currentNews.createdDate;
        newsViewController.imageURL = currentNews.fullTextImageURL;
    }

}