//
//  UserLiveVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 01/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class UserLiveVC: UIViewController {
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - Status bar style
    //  override var preferredStatusBarStyle : UIStatusBarStyle {
   //     return .lightContent
   // }
    // MARK: - Button Actions
    @IBAction func tappedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
