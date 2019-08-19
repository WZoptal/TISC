//
//  UserFurtherNotificationCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 28/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class UserFurtherNotificationCell: UITableViewCell {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var imgVwSelection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
