//
//  MyProfileViewController.swift
//  Connection
//
//  Created by Edward on 8/3/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class MyProfileViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    // username is phone number
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = FIRAuth.auth()?.currentUser?.email
        DataService.dataService.CURRENT_USER_REF.child("username").observeSingleEventOfType(.Value, withBlock: { snapchat in
            let snap = snapchat.value
            self.phoneNumber.text = snap as? String
        })
        DataService.dataService.CURRENT_USER_REF.child("password").observeSingleEventOfType(.Value, withBlock: { snapchat in
            let snap = snapchat.value
            self.password.text = snap as? String
        })
        address.hidden = true
        addressLabel.hidden = true
        DataService.dataService.CURRENT_USER_REF.child("status").observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let snap = snapshot.value {
                if snap as! String == "host"{
                    self.address.hidden = false
                    self.addressLabel.hidden = false
                    DataService.dataService.CURRENT_USER_REF.child("address").observeSingleEventOfType(.Value, withBlock: { snapchat in
                        let snap = snapchat.value
                        self.address.text = snap as? String
                    })
                }
            }
            })
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func saveProfileButton(sender: AnyObject) {
        DataService.dataService.CURRENT_USER_REF.child("username").setValue(phoneNumber.text)
        let user = FIRAuth.auth()?.currentUser!
        if let user = user{
            user.updateEmail(email.text!, completion: { (error) in
                if let error = error {
                    print(error.description)
                }else{
                    DataService.dataService.CURRENT_USER_REF.child("email").setValue(self.email.text)
                }
            })
            user.updatePassword(password.text!, completion: { (error) in
                if let error = error {
                    print(error.description)
                }else{
                    DataService.dataService.CURRENT_USER_REF.child("password").setValue(self.password.text)
                }
            })
        }
        DataService.dataService.CURRENT_USER_REF.child("status").observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let snap = snapshot.value {
                if snap as! String == "host"{
                    DataService.dataService.CURRENT_USER_REF.child("address").setValue(self.address.text)
                }
            }
        })
    }
}
