//
//  TiscUsersCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 29/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class TiscUsersCell: UITableViewCell {
    @IBOutlet weak var lbl_FriendName: UILabel!
    @IBOutlet weak var lbl_FriendAddress: UILabel!
    @IBOutlet weak var lbl_FriendActiveStatus: UILabel!
    @IBOutlet weak var btn_AddFriend: UIButton!
    @IBOutlet weak var img_Friend: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
