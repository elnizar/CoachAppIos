//
//  Constants.swift
//  coachApp
//
//  Created by ESPRIT on 27/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
