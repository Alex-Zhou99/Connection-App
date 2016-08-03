//
//  LoginView.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func dismissKeyboard(tap: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @IBAction func logInDidTapped(sender: AnyObject)
    {
        let email = emailField.text!
        let password = passwordField.text!
        
        if email != "" && password != ""
        {
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: {(user, error) in
                if error != nil {
                    self.showErrorAlert("Alert", msg: "Check your username and password.")
                }else{
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: "uid")
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                }
                }
            )
        }else {
            showErrorAlert("Alert", msg: "Don't forget to enter your email and password.")
        }
    }
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
