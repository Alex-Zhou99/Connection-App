//
//  SignUpVolunteerViewController.swift
//  Connection
//
//  Created by Edward on 8/1/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase


class SignUpVolunteerViewController: UIViewController {
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backToSelect(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelDidTapped(sender: AnyObject) {
        //返回指定页面！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    }
    
    @IBAction func SignUpDidTapped(sender: AnyObject) {
        let username = UsernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextFeild.text!
        
        if username != "" && email != "" && password != "" {
            
            // Set Email and Password for the New User.
            
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                
                if error != nil {
                    print(error)
                    
                    // There was a problem.
                    self.showErrorAlert("Alert", msg: "Check your email and password. Your password must be at least six characters.")
                    
                } else {
                    
                    // Create and Login the New User with authUser
                    
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: "uid")
                    
                    let userData = ["provider":  "email"]
                    
                    DataService.dataService.createNewAccount2(user!.uid, user: userData)
                    
                    
                    // Enter the app.
                    self.performSegueWithIdentifier("loggedIn2", sender: nil)
                }
            })
            
        } else {
            showErrorAlert("Alert", msg: "Don't forget to enter your email, password, and a username.")
        }
        
    }
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
