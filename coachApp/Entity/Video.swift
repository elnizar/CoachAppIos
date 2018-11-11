//
//  Video.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Video {
    var id: Int?
    var user: User?
    var name: String?
    var url: String?
    var description: String?
    var nbJaime: Int?
    var nbComment: Int?
    var domain: Domain?
    var speciality: Speciality?
    
    init(id: Int, user: User, name: String,url: String,description: String,nbJaime: Int , nbComment: Int,domain: Domain,speciality: Speciality) {
        self.id = id
        self.user = user
        self.name = name
        self.url = url
        self.description = description
        self.nbJaime = nbJaime
        self.nbComment = nbComment
        self.domain = domain
        self.speciality = speciality
    }

}
