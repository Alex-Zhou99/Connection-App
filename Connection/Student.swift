//
//  Student.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import Foundation
import Firebase

class Student {
    
    
    private var _studentRef: FIRDatabaseReference!
    private var _studentKey: String!
    private var _studentDescription: String!
    private var _host: String!
    private var _volunteer: String!
    
    var studentKey: String {
        return _studentKey
    }
    
    var studentDescription: String {
        return _studentDescription
    }
    
    var host: String {
        return _host
    }
    var volunteer: String{
        return _volunteer
    }
    
    // Initialize the new Joke
    init(description: String, host: String, volunteer: String) {
        self._studentDescription = description
        self._host = host
        self._volunteer = volunteer
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._studentKey = key
        
        
        if let desc = dictionary["description"] as? String {
            self._studentDescription = desc
        }
        
        if let vol = dictionary["volunteer"] as? String {
            self._volunteer = vol
        }
        if let hosted = dictionary["host"] as? String {
            self._host = hosted
        }
        
        // The above properties are assigned to their key.
        self._studentRef = DataService.dataService.STUT_REF.childByAppendingPath(self._studentKey)
    }
    
    func addSubtractVote(addVote: Bool) {
        
 //       let uid = FIRAuth.auth()?.currentUser?.uid
        if addVote{            
 /*           let desc = FIRDatabase.database().reference().child("users").child(uid!).child("desc").childByAutoId()
            desc.setValue(_studentDescription)*/
            //DataService.dataService.STUT_REF.childByAppendingPath(self._studentKey).removeValue()
            DataService.dataService.STUT_REF.childByAppendingPath(self._studentKey).child("host").setValue("hostfalse")
           
        }else{
            
            DataService.dataService.CURRENT_USER_REF.child("student").childByAppendingPath(self._studentKey).removeValue()
        }
        
 
        
        
    }
}