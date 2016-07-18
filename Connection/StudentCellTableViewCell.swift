//
//  StudentCellTableViewCell.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase

class StudentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var studentDescription: UITextView!
//    @IBOutlet weak var usernameLabel: UILabel!
 //   @IBOutlet weak var totalVotesLabel: UILabel!
    @IBOutlet weak var thumbVoteImage: UIImageView!

    
    var student: Student!
    var studentRef: FIRDatabaseReference!
    
    func configureCell(student: Student) {
        self.student = student
        
        // Set the labels and textView.
        
        self.studentDescription.text = student.studentDescription

        
        // Set "votes" as a child of the current user in Firebase and save the joke's key in votes as a boolean.
        
        studentRef = DataService.dataService.CURRENT_USER_REF.child("student").child(student.studentKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // Set the thumb image.
            
            if (snapshot.value as? NSNull) != nil {

                self.thumbVoteImage.image = UIImage(named: "add-button-blue-hi")
                
            } else {
                
                // Current user voted for the joke!
                
                self.thumbVoteImage.image = UIImage(named: "add-button-blue-hi")
            }
        })
    }

    func voteTapped(sender: UITapGestureRecognizer) {
        
        // observeSingleEventOfType listens for a tap by the current user.
        
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if (snapshot.value as? NSNull) != nil {
                
                self.thumbVoteImage.image = UIImage(named: "add-button-blue-hi")
                self.studentRef.child("description").setValue(self.student?.studentDescription)
//                self.studentRef.setValue(self.student?.studentDescription)
                self.student.addSubtractVote(true)
                
                
            }
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(StudentCellTableViewCell.voteTapped(_:)))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }


}
