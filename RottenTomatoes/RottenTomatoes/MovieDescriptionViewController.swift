//
//  MovieDescriptionViewController.swift
//  RottenTomatoes
//
//  Created by Rohan Shah on 9/15/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class MovieDescriptionViewController: UIViewController {

    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieDescriptionLabel.text = movie["synopsis"] as? String
        movieNameLabel.text = movie["title"] as? String
        titleNavigationItem.title = movieNameLabel.text
        var url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)
        movieCoverImageView.setImageWithURL(url!)
        

        // Do any additional setup after loading the view.
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
