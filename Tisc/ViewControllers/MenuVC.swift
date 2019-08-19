//  Copyright © 2017 ThaparMac. All rights reserved.

import UIKit

class MenuVC: UIViewController {
    //MARK:- Variables Declaration
    var array_MenuOptions = [Dictionary<String,String>]()
    
    //MARK:- Outlets Declaration
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var table_Menu: UITableView!
    @IBOutlet weak var constraint_MenuHeight: NSLayoutConstraint!
    
    //MARK:- Load View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable Interactive pop gesture (back swipe from edge)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.viewInitialSetUp()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    //MARK:- Button Methods
    @IBAction func closeMenuTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            //self.view.layoutIfNeeded()
            //self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
     //MARK:- Custom Methods
    func viewInitialSetUp() {
        self.view.backgroundColor = BLACK_COLOR.withAlphaComponent(0.45)
        table_Menu.tableFooterView = UIView()
        table_Menu.showsVerticalScrollIndicator = false
        table_Menu.bounces = false
        self.updateMenuOptionsArray()
        lbl_UserName.text = USERDEFAULTS_GET_STRING_KEY(key: "User_Name")
        img_User.layer.cornerRadius = (self.view.bounds.width * 0.295)/2
        img_User.clipsToBounds = true
        img_User.contentMode = .scaleAspectFill
        img_User.image = UIImage(named:"logo")
        if USERDEFAULTS_GET_STRING_KEY(key: "Profile_Image").isEmpty == false {
            let url = URL(string:USERDEFAULTS_GET_STRING_KEY(key: "Profile_Image").replacingOccurrences(of: " ", with: "%20"))!
//            img_User.hnk_setImageFromURL(url)
        }
    }
    func updateMenuOptionsArray() {
        if USERDEFAULTS_GET_STRING_KEY(key: "User_Type").caseInsensitiveCompare("service_provider") == .orderedSame {
            array_MenuOptions.append(["Title":"Profile","Icon":"leftmenuprofile"])
            array_MenuOptions.append(["Title":"Manage Appointments","Icon":"appointment"])
            array_MenuOptions.append(["Title":"Job History","Icon":"leftmenutrans"])
            array_MenuOptions.append(["Title":"My Account","Icon":"myaccounticon"])
            array_MenuOptions.append(["Title":"Product & Spare Parts Catalog","Icon":"producticon"])
            array_MenuOptions.append(["Title":"Service Centre","Icon":"serviceCentreicon"])
            array_MenuOptions.append(["Title":"Settings","Icon":"settingMenuIcon"])
            array_MenuOptions.append(["Title":"Reset Password","Icon":"resetPass"])
            array_MenuOptions.append(["Title":"Logout","Icon":"logOut"])
            //array_MenuOptions.append(["Title":"Delete Account","Icon":"delAcount"])
        }else {
            array_MenuOptions.append(["Title":"Profile","Icon":"leftmenuprofile"])
            array_MenuOptions.append(["Title":"Manage Appointments","Icon":"appointment"])
            array_MenuOptions.append(["Title":"Transaction History","Icon":"leftmenutrans"])
            array_MenuOptions.append(["Title":"Service Centre","Icon":"serviceCentreicon"])
            array_MenuOptions.append(["Title":"Settings","Icon":"settingMenuIcon"])
            array_MenuOptions.append(["Title":"Reset Password","Icon":"resetPass"])
            array_MenuOptions.append(["Title":"Logout","Icon":"logOut"])
            //array_MenuOptions.append(["Title":"Delete Account","Icon":"delAcount"])
        }
        table_Menu.backgroundColor = CLEAR_COLOR
        self.table_Menu.delegate = self
        self.table_Menu.dataSource = self
        table_Menu.reloadData()
    }
    func openViewControllerBasedOnIdentifier(identifier:String, isAnimated:Bool) -> Void {
        let button = UIButton()
        self.closeMenuTapped(button)
        let destinationViewController : UIViewController! = (self.storyboard!.instantiateViewController(withIdentifier: identifier))
        let topViewController : UIViewController = self.navigationController!.topViewController!
        if topViewController.restorationIdentifier! == destinationViewController.restorationIdentifier {
            let button = UIButton()
            self.closeMenuTapped(button)
        } else {
            for viewController in self.navigationController!.viewControllers{
                if viewController.restorationIdentifier == destinationViewController.restorationIdentifier {
                    _ = self.navigationController?.popToViewController(viewController, animated: false)
                    return
                }
            }
            if topViewController.restorationIdentifier != destinationViewController.restorationIdentifier {
                    _ =  self.navigationController?.pushViewController(destinationViewController, animated: isAnimated)
            }
        }
    }
    func logoutUserFromApp() {
        SHOW_ALERT_CONTROLLER_DOUBLE_BUTTON(alertTitle: ALERT, message: "Are you sure you want to logout?", btnTitle1: "Cancel", btnTitle2: "Logout", viewController: self) { (response) in
            if response.caseInsensitiveCompare("Button2") == .orderedSame {
                self.callLogoutCurrentUser()
            }
        }
    }
    func deleteUserAccount() {
        SHOW_ALERT_CONTROLLER_DOUBLE_BUTTON(alertTitle: ALERT, message: "Are you sure you want to delete your account?", btnTitle1: "Cancel", btnTitle2: "Delete", viewController: self) { (response) in
            if response.caseInsensitiveCompare("Button2") == .orderedSame {
                SHOW_ALERT_CONTROLLER_DOUBLE_BUTTON(alertTitle: ALERT, message: "You will not be able to recover your account's detail and data once your account is deleted.", btnTitle1: "Cancel", btnTitle2: "I Agree", viewController: self) { (response) in
                    if response.caseInsensitiveCompare("Button2") == .orderedSame {
                        //self.callDeleteUserAccount()
                    }
                }
            }
        }
    }
}

//MARK:- Table View Delegates and Datasources
extension MenuVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.bounds.width * 0.125)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_MenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")!
        cell.backgroundColor = CLEAR_COLOR
        cell.contentView.backgroundColor = CLEAR_COLOR
        let img_Menu = cell.contentView.viewWithTag(100) as! UIImageView
        img_Menu.image = UIImage(named:array_MenuOptions[indexPath.row]["Icon"]!)
        
        let lbl_Title = cell.contentView.viewWithTag(200) as! UILabel
        lbl_Title.text = array_MenuOptions[indexPath.row]["Title"]
        lbl_Title.backgroundColor = CLEAR_COLOR
        /*
        if indexPath.row == array_MenuOptions.count-1 {
            lbl_Title.textColor = RED_COLOR
        }else {
            lbl_Title.textColor = WHITE_COLOR
        }
 */
        lbl_Title.textColor = WHITE_COLOR
        SET_LABEL_FONT(label: lbl_Title, font: MEDIUM_FONT, size: 17)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if USERDEFAULTS_GET_STRING_KEY(key: "User_Type").caseInsensitiveCompare("service_provider") == .orderedSame {
            if indexPath.row == 0 {
                //Profile
                self.openViewControllerBasedOnIdentifier(identifier: "ContractorProfile", isAnimated: true)
            }else if indexPath.row == 1 {
                //Manage Appointments
                self.openViewControllerBasedOnIdentifier(identifier: "ManageAppointments", isAnimated: true)
            }else if indexPath.row == 2 {
                //Job History
                self.openViewControllerBasedOnIdentifier(identifier: "JobHistory", isAnimated: true)
            }else if indexPath.row == 3 {
                //My Account
                self.openViewControllerBasedOnIdentifier(identifier: "MyAccount", isAnimated: true)
            }else if indexPath.row == 4 {
                //Product & Spare Part Catalog
                self.openViewControllerBasedOnIdentifier(identifier: "ContractorQuotation", isAnimated: true)
            }else if indexPath.row == 5 {
                //Service Centre
                self.openViewControllerBasedOnIdentifier(identifier: "ServiceCentre", isAnimated: true)
            }else if indexPath.row == 6 {
                //Settings
                self.openViewControllerBasedOnIdentifier(identifier: "Settings", isAnimated: true)
            }else if indexPath.row == 7 {
                //Reset Password
                self.openViewControllerBasedOnIdentifier(identifier: "ResetPassword", isAnimated: true)
            }else if indexPath.row == 8 {
                //Logout
                self.logoutUserFromApp()
            }/*else if indexPath.row == 9 {
                //Delete Account
                self.deleteUserAccount()
                
            }*/
        }else {
            if indexPath.row == 0 {
                //Profile
                self.openViewControllerBasedOnIdentifier(identifier: "SubscriberProfile", isAnimated: true)
            }else if indexPath.row == 1 {
                //Manage Appointments
                self.openViewControllerBasedOnIdentifier(identifier: "ManageAppointments", isAnimated: true)
            }else if indexPath.row == 2 {
                //Transaction History
                self.openViewControllerBasedOnIdentifier(identifier: "JobHistory", isAnimated: true)
            }else if indexPath.row == 3 {
                //Service Centre
                self.openViewControllerBasedOnIdentifier(identifier: "ServiceCentre", isAnimated: true)
            }else if indexPath.row == 4 {
                //Settings
                self.openViewControllerBasedOnIdentifier(identifier: "Settings", isAnimated: true)
            }else if indexPath.row == 5 {
                //Reset Password
                self.openViewControllerBasedOnIdentifier(identifier: "ResetPassword", isAnimated: true)
            }else if indexPath.row == 6 {
                //Logout
                self.logoutUserFromApp()
            }/*else if indexPath.row == 7 {
                //Delete Account
                self.deleteUserAccount()
            }*/
        }
    }
}

//MARK:- Web service Methods
extension MenuVC {
    func callLogoutCurrentUser() {
        let parameters : [String:Any] = ["userid":USERDEFAULTS_GET_INT_KEY(key: "User_ID")]
        POST_DATA_TO_SERVER(parameters: parameters as NSDictionary, api: LOGOUT_USER, isShowLoader: true, forView: view, success: { (success, response) in
            let responseObj = response.value as! NSDictionary
            print("Logout User: \(responseObj)")
            switch (responseObj["RespCode"] as! NSString).intValue{
            case 4003:
                fallthrough
            default:
                UIView.animate(withDuration: 0.1, animations: {
                    let btn = UIButton()
                    self.closeMenuTapped(btn)
                }) { (success) in
                    USERDEFAULTS_SET_BOOL_KEY(object: false, key: "UserLoggedIn")
                    USERDEFAULTS_SET_STRING_KEY(object: "", key: "User_Type")
                    USERDEFAULTS_SET_INT_KEY(object: 0 , key: "User_ID")
                    USERDEFAULTS_SET_STRING_KEY(object: "", key: "User_Name")
                    USERDEFAULTS_SET_STRING_KEY(object: "", key: "User_Type")
                    USERDEFAULTS_SET_STRING_KEY(object: "", key: "Profile_Image")
                    USERDEFAULTS_SET_BOOL_KEY(object: false, key: "IsJobScopeAddedByContractor")
                    _ = self.navigationController?.popToViewController(((self.navigationController?.viewControllers[1])! as UIViewController), animated: true)
                }
            }
        }) { (failure, error) in
            print("Logout User API Error: \(error)")
        }
    }
    func callDeleteUserAccount() {
        
    }
}
