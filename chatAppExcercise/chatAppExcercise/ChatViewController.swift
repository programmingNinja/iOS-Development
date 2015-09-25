//
//  ChatViewController.swift
//  chatAppExcercise
//
//  Created by Rohan Shah on 9/24/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    var username: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSend(sender: AnyObject) {
        var gameScore = PFObject(className:"Message")
        gameScore.setObject(messageTextField.text, forKey: "text")
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                gameScore.save()
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var destinationViewController = segue.destinationViewController as! LoginViewController
        
        
        
    }
    

}
