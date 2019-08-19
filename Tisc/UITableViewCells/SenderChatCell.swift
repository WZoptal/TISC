//
//  SenderChatCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 03/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class SenderChatCell: UITableViewCell {
    
    @IBOutlet weak var img_MyProfile: UIImageView!
    @IBOutlet weak var lbl_MyMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
