//
//  InboxReadCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 30/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var lbl_MessageReceived: UILabel!
    @IBOutlet weak var img_SenderProfilePic: UIImageView!
    @IBOutlet weak var vw_Background: UIView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
