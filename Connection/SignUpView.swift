//
//  SignUpView.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase


class SignUpView: UIViewController {
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
    }
    
    @IBAction func CancelDidTapped(sender: AnyObject) {
        do{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logInVC = storyboard.instantiateViewControllerWithIdentifier("LogInVC")
            UIApplication.sharedApplication().keyWindow?.rootViewController = logInVC
        }catch let signOutError as NSError{
            print("Error signing out : \(signOutError)")
        }
    }
    @IBAction func SignUpDidTapped(sender: AnyObject) {
        let username = UsernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextFeild.text!
        if username != "" && email != "" && password != "" {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error)
                    self.showErrorAlert("Alert", msg: "Check your email and password. Your password must be at least six characters.")
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: "uid")
                    DataService.dataService.CURRENT_USER_REF.setValue(["username": username, "email": email, "password": password, "status": "host"])
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
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
