//
//  EventCollectionCell.swift
//  Tisc
//
//  Created by Ranjana Prashar on 4/16/19.
//  Copyright © 2019 Eshan Cheema. All rights reserved.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    @IBOutlet weak var vw_VenueBackground: UIView!
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var img_MyProfile: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var lbl_EventDateAndTime: UILabel!
    @IBOutlet weak var img_Event: UIImageView!
    @IBOutlet weak var lbl_EventTitle: UILabel!
    @IBOutlet weak var lbl_EventAddress: UILabel!
    @IBOutlet weak var lbl_EventTime: UILabel!
    @IBOutlet weak var lbl_membersCount: UILabel!
    @IBOutlet weak var btnShowMembersList: UIButton!
    @IBOutlet weak var collectionViewHeightConst: NSLayoutConstraint!    
    @IBOutlet weak var btnEventLike: UIButton!
    @IBOutlet weak var collectionVwTags: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
