
//
//  FriendRequestCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 01/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import SwipeCellKit
class FriendRequestCell: SwipeTableViewCell {
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var btn_RejectRequest: UIButton!
    @IBOutlet weak var btn_ApproveRequest: UIButton!
    @IBOutlet weak var lbl_FriendRequestTitle: UILabel!
    @IBOutlet weak var img_FriendRequest: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class ImageWithTextOnlyCell: SwipeTableViewCell {
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var lbl_FriendRequestTitle: UILabel!
    @IBOutlet weak var img_FriendRequest: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

