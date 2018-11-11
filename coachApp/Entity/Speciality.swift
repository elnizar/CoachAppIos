//
//  Speciality.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Speciality {
    var id: Int?
    var name: String?
    var domain: Domain?
    init(id: Int,name:String,domain: Domain) {
        self.id = id
        self.name = name
        self.domain = domain
    }

}
