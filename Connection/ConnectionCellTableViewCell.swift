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
             self.thumbVoteImage.image = UIImage(named: "cancel-button-md")
        })
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {
        studentRef2 = FIRDatabase.database().reference().child("students").child(student.studentKey)
        studentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.studentRef2.child("host").setValue("hosttrue")
            self.student.addSubtractVote(false)
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConnectionCellTableViewCell.voteTapped(_:)))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }
    
    
}
