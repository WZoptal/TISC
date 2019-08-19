//
//  EventDetailUserDetailCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 18/12/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class EventDetailUserDetailCell: UITableViewCell {
    @IBOutlet weak var img_EventTitle: UIImageView!
    @IBOutlet weak var img_EventCreateBy: UIImageView!
    @IBOutlet weak var lbl_EventCreatedBy: UILabel!
    @IBOutlet weak var lbl_EventCreatorProfile: UILabel!
    @IBOutlet weak var btn_Edit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
