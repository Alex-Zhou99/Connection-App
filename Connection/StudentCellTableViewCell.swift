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
        
        DataService.dataService.CURRENT_USER_REF.child("status").observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let snap = snapshot.value {
                print(snap)
                if snap as! String == "host" && student.host == "hosttrue"
                {
                    self.studentDescription.text = student.studentDescription
                    self.thumbVoteImage.hidden  = false
                    self.studentRef = DataService.dataService.CURRENT_USER_REF.child("student").child(student.studentKey)
                    self.studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                        self.thumbVoteImage.image = UIImage(named: "add-button-blue-hi")
                    })
                }else if snap as! String == "volunteer" && student.volunteer == "volunteertrue"{
                    self.studentDescription.text = student.studentDescription
                    self.thumbVoteImage.hidden  = false
                    self.studentRef = DataService.dataService.CURRENT_USER_REF.child("student").child(student.studentKey)
                    self.studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                        self.thumbVoteImage.image = UIImage(named: "add-button-blue-hi")
                    })
                }else{
                    self.studentDescription.text = "the student has done"
                    self.thumbVoteImage.hidden  = true
                }
            }
        })
    }
    func voteTapped(sender: UITapGestureRecognizer) {
        // observeSingleEventOfType listens for a tap by the current user
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if (snapshot.value as? NSNull) != nil {
                self.studentRef.child("description").setValue(self.student?.studentDescription)
                self.studentRef.child("host").setValue(self.student?.host)
                
                self.student.addSubtractVote(true)

            }
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // UITapGestureRecognizer is set programatically
        let tap = UITapGestureRecognizer(target: self, action: #selector(StudentCellTableViewCell.voteTapped(_:)))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }


}
