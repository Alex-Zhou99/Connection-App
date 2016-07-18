//
//  DataService.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let dataService = DataService()
    
    private var _BASE_REF = URL_BASE
    private var _USER_REF = URL_BASE.child("users")
    private var _STUT_REF = URL_BASE.child("students")
    
    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var STUT_REF: FIRDatabaseReference {
        return _STUT_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
         let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let user = URL_BASE.child("users").child(uid)
        return user

    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        USER_REF.child(uid).updateChildValues(user)
    }
    
   }