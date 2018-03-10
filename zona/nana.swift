//
//  nana.swift
//  zona
//
//  Created by MacDouble on 2/22/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

struct Nana {
    let key:String!
    let profileImage: String!
    let title: String!
    let content: String!
    let poster: String!
    let cat: String!
    let addedBy:String!
    let ref: DatabaseReference?
    
    init(profileImage: String, title: String, content:String,poster: String, cat: String, addedBy:String, key:String = ""){
        self.key = key
        self.profileImage = profileImage
        self.title = title
        self.content = content
        self.poster = poster
        self.cat = cat
        self.addedBy = addedBy
        self.ref = nil
    }
    
    init (snapshot:DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        
        if let nanaValue = snapshot.value as? NSDictionary {
            content = nanaValue["content"] as? String
        }else{
            content = ""
        }
        if let nanaAddedBy = snapshot.value as? NSDictionary {
            addedBy = nanaAddedBy["addedBy"] as? String
        }else{
            addedBy = ""
        }
        if let nanaPoster = snapshot.value as? NSDictionary {
            poster = nanaPoster["poster"] as? String
        }else{
            poster = ""
        }
        if let nanaCat = snapshot.value as? NSDictionary {
            cat = nanaCat["cat"] as? String
        }else{
            cat = ""
        }
        if let nanaImage = snapshot.value as? NSDictionary {
            profileImage = nanaImage["profileImage"] as? String
        }else{
            profileImage = ""
        }
        if let nanaTitle = snapshot.value as? NSDictionary {
            title = nanaTitle["title"] as? String
        }else{
            title = ""
        }
    }
    func toAnyObject() -> Any{
        return ["profileImage": profileImage, "title": title, "content": content, "cat": cat,"poster": poster, "addedBy": addedBy]
    }
   
}
