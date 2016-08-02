//
//  ConnectionCellTableViewCell.swift
//  exmaple
//
//  Created by Edward on 7/14/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase

class ConnectionCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentDescription: UITextView!
    @IBOutlet weak var thumbVoteImage: UIImageView!
    
    var student: Student!
    let  studentRef =  DataService.dataService.CURRENT_USER_REF.child("student")
    var  studentRef2 = FIRDatabase.database().reference().child("students").childByAutoId()
    
    func configureCell(student: Student) {
        self.student = student
        
        // Set the labels and textView.
        
        self.studentDescription.text = student.studentDescription
 
        
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // Set the thumb image.
            
            if (snapshot.value as? NSNull) != nil {
                
                self.thumbVoteImage.image = UIImage(named: "cancel-button-md")
                
            }else {
                
                // Current user voted for the joke!
                
                self.thumbVoteImage.image = UIImage(named: "cancel-button-md")
            }
        })
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {

        studentRef2 = FIRDatabase.database().reference().child("students").child(student.studentKey)
        // observeSingleEventOfType listens for a tap by the current user.
        
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if (snapshot.value as? NSNull) != nil {
                
                self.thumbVoteImage.image = UIImage(named: "cancel-button-md")
                self.studentRef2.child("description").setValue(self.student?.studentDescription)
                self.studentRef2.child("host").setValue(self.student?.host)
                self.student.addSubtractVote(false)                
            }else{
                self.studentRef2.child("description").setValue(self.student?.studentDescription)
                self.studentRef2.child("host").setValue(self.student?.host)
                //                self.studentRef.child("description").setValue(self.student?.studentDescription)
                self.student.addSubtractVote(false)
                
            }
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConnectionCellTableViewCell.voteTapped(_:)))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }
    
    
}
