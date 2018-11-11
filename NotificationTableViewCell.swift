//
//  NotificationTableViewCell.swift
//  coachApp
//
//  Created by ESPRIT on 10/05/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeago: UILabel!
    @IBOutlet weak var texliked: UILabel!
    @IBOutlet weak var imguser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
