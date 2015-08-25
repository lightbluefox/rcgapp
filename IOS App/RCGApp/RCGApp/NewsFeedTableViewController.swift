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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Получение всех новостей
        itemsReceiver.getAllNews();
        
        //Описываем пул-ту-рефреш
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Потяните вниз, чтобы обновить");
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //self.tableView.addSubview(self.refreshControl!);
        
        //Убираем прозрачность таббара и навбара
        self.navigationItem.title = "НОВОСТИ";
        self.navigationController?.navigationBar.translucent = false;
        self.tabBarController?.tabBar.translucent = false;
        
        //Задаем иконки в таббаре
        let tabBar = self.tabBarController?.tabBar;
        
        tabBar?.tintColor = UIColor.whiteColor();
        let tabItems = tabBar?.items;
        let tabItem0 = tabItems![0] as! UITabBarItem;
        tabItem0.image = UIImage(named:"NewsFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem0.selectedImage = UIImage(named:"NewsFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        let tabItem1 = tabItems![1] as! UITabBarItem;
        tabItem1.image = UIImage(named:"VacFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem1.selectedImage = UIImage(named:"VacFeed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);

        let tabItem2 = tabItems![2] as! UITabBarItem;
        tabItem2.image = UIImage(named:"ContactUs")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        tabItem2.selectedImage = UIImage(named:"ContactUsSelected3")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        
        self.newsFeedTableView.rowHeight = 80;
        
        
    }
    func refresh(sender:AnyObject) {
        itemsReceiver.getAllNews();
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
    // Get the new view controller using [segue destinationViewController].
        var newsViewController =  segue.destinationViewController as! NewsViewController
    //sender is a tapped NewsCellViewController
        let cell = sender as! NewsCellViewController
        
        var indexPath = self.newsFeedTableView.indexPathForCell(cell);
        
        let currentNews = self.itemsReceiver.newsStack[indexPath!.row];
        newsViewController.heading = currentNews.title;
        newsViewController.announcement = currentNews.announcement;
        newsViewController.fullText = currentNews.fullText;
        newsViewController.createdDate = currentNews.createdDate;
        newsViewController.imageURL = currentNews.fullTextImageURL;
    }

}