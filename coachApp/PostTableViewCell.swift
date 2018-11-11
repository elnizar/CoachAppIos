//
//  PostTableViewCell.swift
//  coachApp
//
//  Created by ESPRIT on 27/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
class PostTableViewCell: UITableViewCell {

    @IBOutlet var imageuser: UIImageView!
    
    @IBOutlet var nameuser: UILabel!
    
    
    @IBOutlet var videYoutube: YouTubePlayerView!
    @IBOutlet var likebutton: UIButton!
    
    @IBOutlet var commentbutton: UIButton!
    
    @IBOutlet var nblike: UIButton!
    
    @IBOutlet var titlevideo: UILabel!
    
    @IBOutlet var day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       

    }
    

    
}
