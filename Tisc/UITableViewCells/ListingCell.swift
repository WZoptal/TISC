//
//  ListingCell.swift
//  Tisc
//
//  Created by eshan Cheema on 12/11/18.
//  Copyright © 2018 eshan Cheema. All rights reserved.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var img_Selected: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var img_Profile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
