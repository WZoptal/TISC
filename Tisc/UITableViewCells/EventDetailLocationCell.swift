//
//  EventDetailLocationCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 18/12/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class EventDetailLocationCell: UITableViewCell {
    @IBOutlet weak var lbl_EventVenue: UILabel!
    @IBOutlet weak var lbl_EventLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
