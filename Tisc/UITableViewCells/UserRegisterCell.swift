//
//  UserRegisterCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 23/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class UserRegisterCell: UITableViewCell {
    @IBOutlet weak var img_DisplayText: UIImageView!
    @IBOutlet weak var btn_ShowPassword: UIButton!
    @IBOutlet weak var tf_ResgisterFields: UITextField!
    @IBOutlet weak var img_FieldIntro: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tf_ResgisterFields.textAlignment = .left
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
