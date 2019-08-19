//
//  InboxUnreadCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 30/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import SwipeCellKit

class InboxUnreadCell: SwipeTableViewCell {
    @IBOutlet weak var btn_StarMessage: UIButton!
    @IBOutlet weak var lbl_UnreadTextCount: UILabel!
    @IBOutlet weak var lbl_UnreadText: UILabel!
    @IBOutlet weak var img_SenderProfilePic: UIImageView!
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSentDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
