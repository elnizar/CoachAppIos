//
//  Comment.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Comment {
    var id: Int?
    var user: User?
    var video: Video?
    var contents: String?
    var createdat: String?
    init(id: Int,user:User,video: Video,contents: String , createdat: String) {
        self.id = id
        self.user = user
        self.video = video
        self.contents = contents
        self.createdat = createdat
    }
}
