//
//  RootViewController.swift
//  Join
//
//  Created by Jamie Wright on 6/3/14.
//  Copyright (c) 2014 Brilliant Fantastic. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var welcomeLabel: UILabel?
    var logOutButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel = UILabel(frame: CGRectMake(20.0, 40.0, 280.0, 44.0))
        self.view.addSubview(welcomeLabel)
        
        logOutButton = UIButton(frame: CGRectMake(20.0, 100.0, 280.0, 44.0))
        logOutButton!.setTitle("Log Out", forState: UIControlState.Normal)
        logOutButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        logOutButton!.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5), forState: UIControlState.Highlighted)
        logOutButton!.hidden = true
        logOutButton!.addTarget(self, action: "logOut", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(logOutButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (PFUser.currentUser()) {
            self.welcomeLabel!.text = "Welcome \(PFUser.currentUser().username)"
            self.logOutButton!.hidden = false
        } else {
            self.welcomeLabel!.text = "Please Sign In or Sign Up"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!PFUser.currentUser()) {
            self.presentLogInController()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername  username: String, password: String) -> Bool {
        if (username != nil && password != nil && !username.isEmpty && !password.isEmpty) {
            return true
        }
        
        var alert = UIAlertView()
        alert.title = "Missing Information"
        alert.message = "Make sure you fill out all of the information!"
        alert.addButtonWithTitle("OK")
        alert.show()
        
        
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: Dictionary<String, String>) -> Bool {
        var informationComplete = true
        
        for (k, v) in info {
            if (v.isEmpty) {
                informationComplete = false
                break
            }
        }
        
        if (!informationComplete) {
            var alert = UIAlertView()
            alert.title = "Missing Information"
            alert.message = "Make sure you fill out all of the information!"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        return informationComplete
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentLogInController() {
        // Create the log in view controller
        var logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        
        // Create the sign up view controller
        var signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        
        logInViewController.signUpController = signUpViewController
        
        self.presentViewController(logInViewController, animated: true, completion: nil)
    }
    
    func logOut() {
        PFUser.logOut()
        self.presentLogInController()
    }
}
