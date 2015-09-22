//
//  InstagramViewController.swift
//  instagramFeed
//
//  Created by Rohan Shah on 9/10/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit
import AFNetworking
class InstagramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var data: [NSDictionary]?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var clientId = "367bb259c6de4d8a8ae9910d1290325f"
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=367bb259c6de4d8a8ae9910d1290325f")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.data = json["data"] as? [NSDictionary]
                self.feedTableView.reloadData()
            }
            
        // Do any additional setup after loading the view.
        }
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "handleRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.feedTableView?.addSubview(refreshControl)
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            return data.count
        } else {
            return 0
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = feedTableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! PhotoCell
        
        let tempData = data![indexPath.row]
        //println(tempData)
        let url = NSURL(string: tempData.valueForKeyPath("images.thumbnail.url") as! String)!
        cell.cellImageView.setImageWithURL(url)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func handleRefresh() {
        
        println("Refreshing....")
        var clientId = "367bb259c6de4d8a8ae9910d1290325f"
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=367bb259c6de4d8a8ae9910d1290325f")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.data = json["data"] as? [NSDictionary]
                self.feedTableView.reloadData()
            }
            
        }
        refreshControl.endRefreshing()
        println("Refreshed....")
        
    }

}
