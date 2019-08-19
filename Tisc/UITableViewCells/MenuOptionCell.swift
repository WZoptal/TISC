//
//  MenuOptionCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 02/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    @IBOutlet weak var lbl_MenuTitle: UILabel!
    @IBOutlet weak var img_MenuOption: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
