//
//  EventInvitingPeopleCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 20/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class EventInvitingPeopleCell: UITableViewCell {

    @IBOutlet weak var collection_InvitingPeople: UICollectionView!
    @IBOutlet weak var vw_Background: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
