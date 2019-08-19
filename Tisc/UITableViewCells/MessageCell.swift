//
//  MessageCell.swift
//  DryCleaners
//
//  Created by Apple on 8/29/17.
//  Copyright © 2017 SFS04. All rights reserved.
//

import UIKit
import SwipeCellKit
class MessageCell: SwipeTableViewCell {
    
    //Properties
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblText: UILabel!
    
    @IBOutlet var viewContainer: UIView!
    
    @IBOutlet var imgProfile: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none        
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height / 2
        self.imgProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
