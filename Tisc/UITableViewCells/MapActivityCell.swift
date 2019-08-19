//
//  MapActivityCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 30/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import Lottie.Swift

class MapActivityCell: UITableViewCell {

    @IBOutlet weak var btn_NumberOfLikes: UIButton!
    @IBOutlet weak var btn_SharePost: UIButton!
    @IBOutlet weak var btn_MessageFriend: UIButton!
    @IBOutlet weak var lbl_WatchingCount: UILabel!
    @IBOutlet weak var lbl_LikeCount: UILabel!
    @IBOutlet weak var btn_Like: UIButton!
    @IBOutlet weak var lbl_StatusDuration: UILabel!
    @IBOutlet weak var lbl_FriendStatus: UILabel!
    @IBOutlet weak var lbl_FriendTitle: UILabel!
    @IBOutlet weak var img_FriendProfile: UIImageView!
    @IBOutlet weak var img_CheckInOrLive: UIImageView!
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var btnWatching: UIButton!
    @IBOutlet weak var btnEditDeleteActivity: UIButton!
    @IBOutlet weak var btnLikeOut: AnimatedButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
