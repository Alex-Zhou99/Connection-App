//
//  ConnectionViewController.swift
//  exmaple
//
//  Created by Edward on 7/14/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase

class ConnectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    let studentRef = FIRDatabase.database().reference()
    var student = [Student]()
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
         _ = DataService.dataService.CURRENT_USER_REF.child("student").observeEventType(.Value, withBlock: {
            snapshot in
            self.student = []
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let student = Student(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes
                        self.student.append(student)
                        //self.student.insert(student, atIndex: 0)
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            self.tableView.reloadData()
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.student.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let stu = student[indexPath.row]
        
        // We are using a custom cell.
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ConnectionCellTableViewCell") as? ConnectionCellTableViewCell {
            
            // Send the single joke to configureCell() in JokeCellTableViewCell.
            
            cell.configureCell(stu)
            
            return cell
            
        } else {
            
            return ConnectionCellTableViewCell()
            
        }
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        let firebaseAuth = FIRAuth.auth()
        do{
            try firebaseAuth?.signOut()
            let logInVC = self.storyboard!.instantiateViewControllerWithIdentifier("LogInVC")
            UIApplication.sharedApplication().keyWindow?.rootViewController = logInVC
        }catch let signOutError as NSError{
            print("Error signing out: \(signOutError)")
        }
 
    }
    
}
