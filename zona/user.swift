//
//  user.swift
//  zona
//
//  Created by MacDouble on 2/22/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

struct user {
    
    let email:String!
    let key:String!
    let name: String!
    let school:String!
    let bio:String!
    let ref: DatabaseReference?
    
    init(email: String, name: String, school:String, bio:String, key:String = ""){
        self.key = key
        self.name = name
        self.email = email
        self.school = school
        self.bio = bio
        self.ref = nil
    }
    
    init (snapshot:DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        
        if let nanaValue = snapshot.value as? NSDictionary {
            school = nanaValue["school"] as? String
        }else{
            school = ""
        }
        if let nanaAddedBy = snapshot.value as? NSDictionary {
            bio = nanaAddedBy["bio"] as? String
        }else{
            bio = ""
        }
        if let nanaTitle = snapshot.value as? NSDictionary {
            email = nanaTitle["email"] as? String
        }else{
            email = ""
        }
        if let nanaValue = snapshot.value as? NSDictionary {
            name = nanaValue["name"] as? String
        }else{
            name = ""
        }
    }
    func toAnyObject() -> Any{
        return ["email": email, "name": name, "school": school, "bio": bio]
    }
    
}

