//
//  UserEditDetailsCell.swift
//  Tisc
//
//  Created by eshan Cheema on 29/01/19.
//  Copyright © 2019 Eshan Cheema. All rights reserved.
//

import UIKit

class UserEditDetailsCell: UITableViewCell {
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var tf_UserDetail: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
