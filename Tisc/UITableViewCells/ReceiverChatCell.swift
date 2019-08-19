//
//  ReceiverChatCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 03/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class ReceiverChatCell: UITableViewCell {
    
    @IBOutlet weak var lbl_ReceiverMessage: UILabel!
    @IBOutlet weak var img_ReceiverProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
