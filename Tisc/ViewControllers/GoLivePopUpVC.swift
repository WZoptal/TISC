//
//  GoLivePopUpVC.swift
//  TISC
//
//  Created by Eshan Cheema on 29/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
protocol MakeUserLiveProtocol {
    func makeUserLiveForDismissal()
}

class GoLivePopUpVC: BaseViewController {
    // MARK: - Outlet Declarations
    @IBOutlet weak var txtVw_GoLiveStatus: UITextView!
    var delegateDismissal : MakeUserLiveProtocol?
    var liveDetails : NewsFeeds?
    // MARK: - View Life Cycle
    @IBOutlet weak var btnGoLiveOut: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialSetUp()
         self.ifUserEditingtPost()
    }
    
    // MARK: - Button Actions
    @IBAction func tappedClosePopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedGoLive(_ sender: Any) {
        if txtVw_GoLiveStatus.text.caseInsensitiveCompare("Ask what's going on around you or tell your friends what you're up to.") == .orderedSame{
            AlertInstance.instance.displayAlert(userMessage: "Please update live status")
        } else {
            if txtVw_GoLiveStatus.hasText {
                if let _ = self.presentingViewController {
                    let goLiveNavigator = presentingViewController as? UINavigationController
                    let goLive = goLiveNavigator!.viewControllers[0] as? GoLiveVC
                    if goLive != nil {
                        if (goLive!.isKind(of: GoLiveVC.self) ) {
                            self.dismiss(animated: true) {
                                goLive!.callMakeUserLive(message : self.txtVw_GoLiveStatus.text!)
                            }
                        } else {
                            //  self.dismiss(animated: true) {
                            self.callMakeUserLive(message: self.txtVw_GoLiveStatus.text!)
                            //  }
                        }
                    } else {
                        //   self.dismiss(animated: true) {
                        self.callMakeUserLive(message: self.txtVw_GoLiveStatus.text!)
                        //   }
                    }
                }
            } else {
                SHOW_ALERT_CONTROLLER_SINGLE_BUTTON(alertTitle: APPNAME, message: "Please acknowledge others what you are upto!", btnTitle: "Ok", viewController: self) { (success) in
                    self.txtVw_GoLiveStatus.becomeFirstResponder()
                }
            }
        }
    }
    
    func callMakeUserLive(message : String) {
        if liveDetails != nil {
            let parameters : [String : Any] = ["access_token" : loggedInUser?.accessToken ?? "0",
                                               "location" : "",
                                               "latitude" : USERDEFAULTS_GET_DOUBLE_KEY(key: "locationLattitude"),
                                               "longitude" : USERDEFAULTS_GET_DOUBLE_KEY(key: "locationlongitude"),
                                               "message" : message.trimmingCharacters(in: .whitespacesAndNewlines).encode(),
                                               "friends_list":liveDetails!.friendList!,
                                               "everyone":liveDetails!.everyone!,
                                               "friends":liveDetails!.friends!,
                                               "except_friends":liveDetails!.exceptFriends!,
                                               "selected_friends":liveDetails!.selectedFriends!,
                                               "id":liveDetails!.feedId!]
            print(parameters)
          httpPost(request: GO_LIVE, params: parameters,isShowLoader: true,forView: self.view, successHandler: { (response) in
                print(response)
                if response["code"].stringValue == "200" {
                    let mesz = (self.liveDetails != nil) ? response["message"].stringValue : "Kudos! You're live now."
                    SHOW_ALERT_CONTROLLER_SINGLE_BUTTON(alertTitle: APPNAME, message: mesz, btnTitle: "Cheers!", viewController: self, completionHandler: { (success) in
                        self.dismiss(animated: true, completion: nil)
                        self.delegateDismissal!.makeUserLiveForDismissal()
                        // self.goLiveActive()
                    })
                }else {
                    super.messageChecking(strMessage: response["message"].stringValue, strCode: response["code"].stringValue)
            }
            }) { (Error) in
                print("GO LIVE API Error: \(String(describing: Error?.localizedDescription))")
            }
        }
    }
    
    // MARK: - Custom Methods
    func viewInitialSetUp(){
        self.view.backgroundColor = BLACK_WITH_ALPHA_COLOR
        txtVw_GoLiveStatus.becomeFirstResponder()
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
extension GoLivePopUpVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.caseInsensitiveCompare("Ask what's going on around you or tell your friends what you're up to.") == .orderedSame{
            textView.text = ""
        }
        textView.textColor = BLACK_COLOR
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.caseInsensitiveCompare("") == .orderedSame{
            textView.text = "Ask what's going on around you or tell your friends what you're up to."
            textView.textColor = LIGHTGRAY_COLOR
        }
        textView.resignFirstResponder()
    }
}

// Manage data if user going to edit the Live post/privacy
extension GoLivePopUpVC {
    func ifUserEditingtPost() {
        if liveDetails != nil {
            print(liveDetails!)
            self.btnGoLiveOut.setTitle("Update", for: .normal)
            self.txtVw_GoLiveStatus.text = liveDetails?.liveMessage!.decode()
        }
    }
}
