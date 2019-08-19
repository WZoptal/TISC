//
//  StartChatVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 13/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class StartChatVC: UIViewController {
    
    @IBOutlet weak var btn_StartChat: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func tappedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func tappedStartChat(_ sender: Any) {
        let objMessage = self.storyboard?.instantiateViewController(withIdentifier: "MessageListing") as! MessageListingVC
        self.navigationController?.pushViewController(objMessage, animated: true)
    }
}
