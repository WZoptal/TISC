//
//  FilterVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 03/12/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {
    // MARK: - Outlet Declarations
    @IBOutlet var vw_PopUp: UIView!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialSetUp()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom Methods
    func viewInitialSetUp(){
        self.view.backgroundColor = BLACK_WITH_ALPHA_COLOR
        CREATE_ROUND_CORNER_VIEW(view: vw_PopUp, cornerRadius: 10.0, bgColor: WHITE_COLOR, borderWidth: 0.0, borderColor: CLEAR_COLOR)
        ADD_SHADOW_TO_VIEW(view: vw_PopUp)
    }
    // MARK: - Button Actions
    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tappedMen(_ sender: UIButton) {
        ADD_ANIMATION_TO_VIEW(view: self.view)
        sender.isSelected = !sender.isSelected
    }
    @IBAction func tappedWomen(_ sender: UIButton) {
        ADD_ANIMATION_TO_VIEW(view: self.view)
        sender.isSelected = !sender.isSelected
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
