//
//  ShowPastEventsCell.swift
//  Tisc
//
//  Created by Eshan Cheema on 23/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class ShowPastEventsCell: UITableViewCell {
    @IBOutlet weak var vw_VenueBackground: UIView!
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var img_MyProfile: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var lbl_EventDateAndTime: UILabel!
    @IBOutlet weak var img_Event: UIImageView!
    @IBOutlet weak var lbl_EventTitle: UILabel!
  //  @IBOutlet weak var lbl_EventVenue: UILabel!
    @IBOutlet weak var lbl_EventAddress: UILabel!
    @IBOutlet weak var lbl_EventTime: UILabel!
    @IBOutlet weak var lbl_membersCount: UILabel!
    @IBOutlet weak var btnShowMembersList: UIButton!
    @IBOutlet weak var collectionViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var collectionVwTags: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    @IBOutlet weak var btnAddFav: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
