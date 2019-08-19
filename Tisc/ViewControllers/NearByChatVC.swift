//
//  NearByChatVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 30/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class NearByChatVC: UIViewController {
    // MARK: - Outlet Declarations
    @IBOutlet weak var vw_PopUp: UIView!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewInitialSetUp()
    }
    
    // MARK: - Button Actions
    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedApprove(_ sender: Any) {
        
    }
    
    @IBAction func tappedDeny(_ sender: Any) {
        
    }
    
    // MARK: - Custom Methods
    func viewInitialSetUp() {
        vw_PopUp.roundCorners(corners: [.topLeft, .topRight], radius: 10.0, height : self.view.bounds.height)
        self.view.backgroundColor = BLACK_COLOR
    }
}
