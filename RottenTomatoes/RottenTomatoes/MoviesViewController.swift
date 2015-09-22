//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Rohan Shah on 9/14/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit
import SwiftLoader
import TSMessages

enum MoviesEndpoint {
    case Theater
    case DVD
}

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var endpoint:MoviesEndpoint = .Theater

    var refreshControl: UIRefreshControl!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    var searchActive : Bool = false
    var movies: [NSDictionary]?
    var filtered: [NSDictionary]?
    //@IBOutlet weak var movieDVDSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "handleRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.movieTableView?.addSubview(refreshControl)
        //movieTableView.
        handleRefresh()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        moviesSearchBar.delegate = self
        //moviesSearchBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = movieTableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        cell.titleLabel?.text = movie["title"] as? String
        cell.descriptionLabel?.text = movie["synopsis"] as? String
        let tempData = movies![indexPath.row]
        
        var url = NSURL(string: tempData.valueForKeyPath("posters.thumbnail") as! String)
       
        /*
        var range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }*/
        
        cell.movieCoverImageView.setImageWithURL(url!)
        let request = NSURLRequest(URL: url!)
        cell.movieCoverImageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
            cell.movieCoverImageView.alpha = 0.0
            cell.movieCoverImageView.image = image
            UIView.animateWithDuration(1.0, animations: {
                cell.movieCoverImageView.alpha = 1.0
            })
            }, failure: nil)
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = movieTableView.indexPathForCell(cell)!
        let movie = movies![indexPath.row]
        
        let movieDescrViewController = segue.destinationViewController as! MovieDescriptionViewController
        movieDescrViewController.movie = movie
    }

    func showLoader() {
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 170
        config.backgroundColor = UIColor(red:0.03, green:0.82, blue:0.7, alpha:1)
        config.spinnerColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.titleTextColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.spinnerLineWidth = 2.0
        
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        showLoader()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
        SwiftLoader.hide()
    }
    
    func reloadMoviesTableView() {
        var url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            
            TSMessage.dismissActiveNotification()
            
            var errorValue: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary {
                self.movies = json["movies"] as? [NSDictionary]
                self.movieTableView.reloadData()
            } else {
                TSMessage.showNotificationWithTitle("Network error",subtitle: "Couldn't connect to the server. Check your network connection.",
                    type: .Error
                )
            }
        
        }
    }
    
    func reloadDVDTableView() {
        var url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.movies = json["movies"] as? [NSDictionary]
                self.movieTableView.reloadData()
                
            }
        }
    }
    func handleRefresh() {
        println("Refreshing...")
        switch (endpoint) {
        case .Theater:
            reloadMoviesTableView()
        case .DVD:
            reloadDVDTableView()
        }
        
        refreshControl.endRefreshing()
        println("Refreshed....")
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    /*@IBAction func onChange(sender: AnyObject) {
        if(movieDVDSegment.selectedSegmentIndex == 0) {
            reloadMoviesTableView()
        }
        else {
            reloadDVDTableView()
        }
    }*/
    /*func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = movies!.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.movieTableView.reloadData()
    }*/

}

class MoviesTabBarController:UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let viewController = (self.viewControllers![1] as! UINavigationController)
        let controller = viewController.viewControllers!.first! as! MoviesViewController
        controller.endpoint = .DVD
        
    }
}
