//
//  ViewController.swift
//  chatAppExcercise
//
//  Created by Rohan Shah on 9/24/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //var loginAccount = PFObject(className: "AccountLogin")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text, password:passwordTextField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("goToChat", sender: self)
                }
            } else {
                // The login failed. Check error to see why.
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = "cricket@yahoo.com";
        //user.save()
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("goToChat", sender: self)
                }
                /*PFUser.logInWithUsernameInBackground(usernameTextField.text, password:passwordTextField.text) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Do stuff after successful login.
                    } else {
                        // The login failed. Check error to see why.
                    }
                }*/
            }
        }
}
}
   


