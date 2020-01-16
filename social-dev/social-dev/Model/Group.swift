//
//  Group.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 16/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import Foundation

class Group {
    public private(set) var title: String
    public private(set) var descr: String
    public private(set) var key: String
    public private(set) var memberCount: Int
    public private(set) var members: [String]
    
    init(title: String, descr: String, key: String, memberCount: Int, members: [String]) {
        self.title = title
        self.descr = descr
        self.key = key
        self.memberCount = memberCount
        self.members = members
    }
    
}
