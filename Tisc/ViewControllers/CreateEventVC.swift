//
//  CreateEventVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 30/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
class CreateEventVC: UIViewController {
    // MARK: - Outlets Declarations
    @IBOutlet weak var vw_Background: UIView!
    @IBOutlet weak var vw_Cancel: UIView!
    
    // MARK: - Variable Declarations
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialSetUp()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vw_Cancel.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0, height : vw_Cancel.bounds.height)
    }
    // MARK: - Button Actions
    @IBAction func tappedGoLive(_ sender: Any) {
        getNewsFeedMethods(methodName: "GoLive",animated: true)
    }
    
    @IBAction func tappedCheckIn(_ sender: Any) {
        getNewsFeedMethods(methodName: "CheckIn",animated: false)
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedCreateEvent(_ sender: Any) {
        getNewsFeedMethods(methodName: "CreateEvent",animated: false)
    }
    //  override var preferredStatusBarStyle : UIStatusBarStyle {
   //     return .lightContent
   // }
    
    // MARK: - Custom Methods
    func getNewsFeedMethods(methodName : String, animated : Bool) {
        if let _ = self.presentingViewController {
            let newsFeedNavigator = presentingViewController as? UINavigationController
            let newsFeed = newsFeedNavigator!.viewControllers[0] as! NewsFeedVC
            self.dismiss(animated: animated) {
                if methodName.caseInsensitiveCompare("CreateEvent") == .orderedSame {
                    newsFeed.navigateToCreateEvent()
                }else if methodName.caseInsensitiveCompare("CheckIn") == .orderedSame {
                    newsFeed.navigateToCheckIn()
                }else{
                   newsFeed.makeUserLive()
//                    if self.delegateDismissal != nil {
//                        self.delegateDismissal?.makeUserLiveForDismissal()
//                    }
                }
            }
        }
    }
    
    func viewInitialSetUp() {
        CREATE_ROUND_CORNER_VIEW(view: vw_Background, cornerRadius: 10.0, bgColor: CLEAR_COLOR, borderWidth: 0.0, borderColor: CLEAR_COLOR)
        self.view.backgroundColor = BLACK_WITH_ALPHA_COLOR
        self.navigationController?.navigationBar.isHidden = true
    }
}
