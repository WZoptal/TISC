//
//  InviteFriendsCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 26/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class InviteFriendsCell: UITableViewCell {
    @IBOutlet weak var lbl_FriendName: UILabel!
    @IBOutlet weak var btn_InviteFriends: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
