//
//  Jaime.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Jaime {
    var id: Int?
    var user: User?
    var video: Video?
    init(id: Int,user:User,video: Video) {
        self.id = id
        self.user = user
        self.video = video
    }

}
