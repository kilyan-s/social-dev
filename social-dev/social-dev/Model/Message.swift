//
//  Message.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import Foundation

class Message {
//    private var _content: String
//    private var _senderId: String
//
//    var content: String {
//        return _content
//    }
//
//    var senderId: String {
//        return _senderId
//    }
//
//    init(content: String, senderId: String) {
//        self._content = content
//        self._senderId = senderId
//    }
    
    public private(set) var content: String
    public private(set) var senderId: String
    
    init(content: String, senderId: String) {
        self.content = content
        self.senderId = senderId
    }
}
