//
//  SettingsCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 05/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var img_Arrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
