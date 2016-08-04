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
        self.studentDescription.text = student.studentDescription
    }
    func voteTapped(sender: UITapGestureRecognizer) {
        studentRef2 = FIRDatabase.database().reference().child("students").child(student.studentKey)
        DataService.dataService.CURRENT_USER_REF.child("status").observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let snap = snapshot.value{
                if snap as! String == "host" {
                    self.studentRef2.child("host").setValue("hosttrue")
                    self.student.addSubtractVote()
                }else{
                    self.studentRef2.child("volunteer").setValue("volunteertrue")
                    self.student.addSubtractVote()
                }
            }
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
