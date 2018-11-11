//
//  NewMessageTableViewCell.swift
//  coachApp
//
//  Created by ESPRIT on 25/04/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class NewMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageuser: UIImageView!

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var fullname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
