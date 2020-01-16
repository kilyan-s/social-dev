//
//  DataService.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 13/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import Foundation
import Firebase


class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData:Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(forUID uid: String, completion: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    let userEmail = user.childSnapshot(forPath: "email").value as! String
                    completion(userEmail) 
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUid uid: String, withGroupKey groupKey: String?, sendComplete: @escaping CompletionHandler) {
        if groupKey != nil {
            //Send to specific group
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(completion: @escaping (_ messages: [Message]) -> () ) {
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                let newMessage = Message(content: content, senderId: senderId)
                messageArray.append(newMessage)
                
                completion(messageArray)
            }
        }
    }
    
    func getEmail(forSearchQuery query: String, completion: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        
        
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            
            completion(emailArray)
        }
    }
    
    func getIds(forUsernames usernames: [String], completion: @escaping (_ uidArray: [String]) -> ()) {
        var idArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let userEmail = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(userEmail) {
                    let userUID = user.key
                    idArray.append(userUID)
                }
            }
            
            completion(idArray)
        }
    }
    
    //PRAGMARK: Groups
    func createGroup(withTitle title: String, andDescription descr: String, forUserIds ids: [String], completion: @escaping CompletionHandler) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": descr, "members": ids])
        completion(true)
    }
    
    func getAllGroups(completion: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArr = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for group in groupSnapshot {
                let groupMembers = group.childSnapshot(forPath: "members").value as! [String]
                if groupMembers.contains(Auth.auth().currentUser!.uid){
                    let groupKey = group.key
                    let groupTitle = group.childSnapshot(forPath: "title").value as! String
                    let groupDescr = group.childSnapshot(forPath: "description").value as! String
                    let membersCount = groupMembers.count
                    
                    let newGroup = Group(title: groupTitle, descr: groupDescr, key: groupKey, memberCount: membersCount, members: groupMembers)
                    groupsArr.append(newGroup)
                }
            }
            
            completion(groupsArr)
        }
    }
    
    
}
