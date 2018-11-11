//
//  User.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class User {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var birthday: String?
    var gender: String?
    var image: String?
    var nbfollow: Int?
    var nbfollowed: Int?
    var phoneNumber: Int?
    var typeUser: String?
    var domain: Domain?
    var listVideo = [User]()

    init(id: Int, firstName: String, lastName: String,email: String,password: String,birthday: String,gender: String,image: String,nbfollow: Int,nbfollowed: Int,phoneNumber: Int,typeUser: String,domain: Domain) {

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.birthday = birthday
        self.gender = gender
        self.image = image
        self.nbfollow = nbfollow
        self.nbfollowed = nbfollowed
        self.phoneNumber = phoneNumber
        self.typeUser = typeUser
        self.domain = domain
    }
}
