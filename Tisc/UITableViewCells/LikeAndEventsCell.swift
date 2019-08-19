//
//  LikeAndEventsCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 01/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import SwipeCellKit
class LikeAndEventsCell: SwipeTableViewCell {

    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var img_LikedPost: UIImageView!
    @IBOutlet weak var img_EventSchedule: UIImageView!
    @IBOutlet weak var lbl_EventName: UILabel!
    @IBOutlet weak var lbl_TitleLikeDetail: UILabel!
    @IBOutlet weak var img_FriendLikedBy: UIImageView!
    @IBOutlet weak var imgVwRightArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
