//  Copyright © 2017 ThaparMac. All rights reserved.

import UIKit

class ParentVC: UIViewController {
    //MARK:- Variables Declaration
    let tabBar = UITabBar()
    
    //MARK:- Outlets Declaration
    
    //MARK:- Load View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable Interactive pop gesture (back swipe from edge)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
    
    //MARK:- Custom Methods
    //**************** Menu Button ************************//
    func ADD_MENU_BUTTON_TO_VIEW() {
        let btn_Menu = UIButton(type: UIButton.ButtonType.custom)
        btn_Menu.setImage(UIImage(named:"menuIcon"), for: UIControl.State())
        if UIDevice().SCREEN_TYPE == .iPhoneX {
         btn_Menu.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width*0.1449, height: UIScreen.main.bounds.width*0.1207)
        }else {
           btn_Menu.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width*0.1449, height: UIScreen.main.bounds.width*0.1207)
        }
        
        btn_Menu.addTarget(self, action: #selector(self.menuTapped(_:)), for: .touchUpInside)
        self.view.addSubview(btn_Menu)
    }
    @objc func menuTapped(_ sender : UIButton){
        sender.isUserInteractionEnabled = false
        let menuVC : MenuVC = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! MenuVC
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        self.view.endEditing(true)
        menuVC.view.layoutIfNeeded()
        menuVC.view.frame=CGRect(x: 0 - self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        UIView.animate(withDuration: 0.3, animations: {
            menuVC.view.frame=CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }) { (success) in
           sender.isUserInteractionEnabled = true
        }
    }
    //*********************************************************//
    
    //**************** Back Button ************************//
    func ADD_BACK_BUTTON_TO_VIEW() {
        let btn_Back = UIButton(type: UIButton.ButtonType.custom)
        btn_Back.setImage(UIImage(named:"backIcon"), for: UIControl.State())
        if UIDevice().SCREEN_TYPE == .iPhoneX {
            btn_Back.frame = CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width*0.1449)), y: 44, width: UIScreen.main.bounds.width*0.1449, height: UIScreen.main.bounds.width*0.1207)
        }else {
            btn_Back.frame = CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width*0.1449)), y: 20, width: UIScreen.main.bounds.width*0.1449, height: UIScreen.main.bounds.width*0.1207)
        }
        btn_Back.addTarget(self, action: #selector(self.backTapped(_:)), for: .touchUpInside)
        self.view.addSubview(btn_Back)
    }
    @objc func backTapped(_ sender : UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    //*********************************************************//
    
    //**************** Tab Bar ************************//
    func ADD_TAB_BAR_TO_VIEW() {
        let bottomView = UIView()
        //Differentiating X and other phones.
        if UIDevice().SCREEN_TYPE == .iPhoneX {
            //bottom safe area = 34 px
         bottomView.frame = CGRect(x: 0, y: self.view.bounds.height-84, width: self.view.bounds.width, height: 84)
        }else {
          bottomView.frame = CGRect(x: 0, y: self.view.bounds.height-50, width: self.view.bounds.width, height: 50)
        }
        self.view.addSubview(bottomView)
        
        let lbl_Border = UILabel(frame: CGRect(x: 0, y: 1, width: self.view.bounds.width, height: 1))
        lbl_Border.text = nil
        lbl_Border.backgroundColor = WHITE_COLOR
        bottomView.addSubview(lbl_Border)
        
        tabBar.frame = CGRect(x: 0, y: 1, width: self.view.bounds.width, height: 49)
        tabBar.barTintColor = GROUPED_TABLE_COLOR
        tabBar.tag = 1000
        tabBar.delegate = self
        bottomView.addSubview(tabBar)
        let tabItem_1 = UITabBarItem()
        
        tabItem_1.title = ""
        tabItem_1.image = UIImage(named:"artists")?.withRenderingMode(.alwaysOriginal)
        tabItem_1.selectedImage = UIImage(named:"artists")?.withRenderingMode(.alwaysOriginal)
        tabItem_1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabItem_1.tag = 100
        
        let tabItem_2 = UITabBarItem()
        tabItem_2.title = ""
        tabItem_2.image = UIImage(named:"home")?.withRenderingMode(.alwaysOriginal)
        tabItem_2.selectedImage = UIImage(named:"home")?.withRenderingMode(.alwaysOriginal)
        tabItem_2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabItem_2.tag = 200
        
        let tabItem_3 = UITabBarItem()
        tabItem_3.title = ""
        tabItem_3.image = UIImage(named:"ember")?.withRenderingMode(.alwaysOriginal)
        tabItem_3.selectedImage = UIImage(named:"ember")?.withRenderingMode(.alwaysOriginal)
        tabItem_3.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabItem_3.tag = 300
        
        /*let tabItem_4 = UITabBarItem()
        tabItem_4.title = "FourthScreen"
        tabItem_4.image = UIImage(named:"newsfeedIcon")?.withRenderingMode(.alwaysOriginal)
        tabItem_4.selectedImage = UIImage(named:"newsfeedIconActive")?.withRenderingMode(.alwaysOriginal)
        //tabItem_4.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabItem_4.tag = 400*/
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:WHITE_COLOR], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:WHITE_COLOR], for:.selected)
        
//        tabBar.items = [tabItem_1, tabItem_2, tabItem_3, tabItem_4]
        tabBar.items = [tabItem_1, tabItem_2, tabItem_3]
    }
    func SELECT_TAB_BAR_ITEM(itemIndex : Int) {
        if (itemIndex >= 0 ) {
            tabBar.selectedItem = tabBar.items?[itemIndex]
        }
    }
    //*********************************************************//
    func openViewControllerBasedOnIdentifier(_ identifier:String) -> Void {
        let destinationViewController : UIViewController! = (self.storyboard!.instantiateViewController(withIdentifier: identifier))
        let topViewController : UIViewController = self.navigationController!.topViewController!
        if topViewController.restorationIdentifier! == destinationViewController.restorationIdentifier {
          print("You are on same view controller")
        } else {
            for viewController in self.navigationController!.viewControllers{
                if viewController.restorationIdentifier == destinationViewController.restorationIdentifier {
                    _ = self.navigationController?.popToViewController(viewController, animated: true)
                    return
                }
            }
            if topViewController.restorationIdentifier != destinationViewController.restorationIdentifier {
                _ =  self.navigationController?.pushViewController(destinationViewController, animated: true)
            }
        }
    }
}

extension ParentVC : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SHOW_AUTOHIDE_MESSAGE(view: self.view, message: "Under progress")
        /*
        if item.tag == 100 {
            SHOW_AUTOHIDE_MESSAGE(view: self.view, message: "Under progress")
//          self.openViewControllerBasedOnIdentifier("FirstScreen")
        }else if item.tag == 200 {
            SHOW_AUTOHIDE_MESSAGE(view: self.view, message: "Under progress")
//           self.openViewControllerBasedOnIdentifier("SecondScreen")
        }else if item.tag == 300 {
          self.openViewControllerBasedOnIdentifier("MyEmber")
        }else if item.tag == 400 {
//            self.openViewControllerBasedOnIdentifier("FourthScreen")
        }
 */
    }
}
