//
//  UserEventsVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 23/11/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import MMBannerLayout
class UserEventsVC: BaseViewController {
    fileprivate var sizingCell: TagCell?
    @IBOutlet weak var tblvwEvents: UITableView!
    var eventDetails : EventDetails?
    @IBOutlet weak var viewCreateEventHeightConst: NSLayoutConstraint!
    @IBOutlet weak var viewYourEvents: UIView!
    @IBOutlet weak var viewLIkedEventHeightConst: NSLayoutConstraint!
    @IBOutlet weak var likedPageCntrl: UIPageControl!
    @IBOutlet weak var viewLIkedEvents: UIView!
    @IBOutlet weak var viewAllEmptyTopConst: NSLayoutConstraint!
    @IBOutlet var carouselVw: iCarousel!
    @IBOutlet weak var viewHeaderHeightConst: NSLayoutConstraint!
    @IBOutlet weak var viewAllempty: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.likedPageCntrl.numberOfPages = 0
        self.carouselVw.type = .rotary
        self.carouselVw.isPagingEnabled=true
        self.viewInitialSetup()
    }
    
    func viewInitialSetup() {
        self.viewLIkedEventHeightConst.constant = 0
        self.viewCreateEventHeightConst.constant = 0
        self.viewAllEmptyTopConst.constant  = 0
        self.viewYourEvents.isHidden=true
        self.viewAllempty.isHidden=false
    }
    
    @IBAction func btnCreateEventsAct(_ sender: Any) {
        let addEvent = self.storyboard?.instantiateViewController(withIdentifier: "AddNewEventVC") as! AddNewEventVC
        self.navigationController?.pushViewController(addEvent, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.callGetEvents(isShowLoader: (eventDetails == nil) ? true : false)
        if (eventDetails != nil) {
            self.setViewAfterAPICall()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func btnTappedBackAct(_ sender: Any) {
        for mainView in self.carouselVw.subviews {
            mainView.removeFromSuperview()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableVwUISetting(strIdentifier:String) {
        let cellNib = UINib(nibName: strIdentifier, bundle: nil)
        tblvwEvents.register(cellNib, forCellReuseIdentifier: strIdentifier)
    }
    
    @IBAction func viewAllEvents(_ sender: Any) {
        super.getAllevents(parameters: ["user_id":(loggedInUser?.userId)!,"access_token":loggedInUser?.accessToken ?? "0", "page_no":"0" ,"no_of_post":"100"], isShowLoader: true) { (response) in
            var arrayEvents = [EventData]()
            let newsFeedsList = response["data"].arrayValue
            for newsFeed in newsFeedsList {
                let newsFeedData  = EventData.init(dictionary: newsFeed)
                arrayEvents.append(newsFeedData)
            }
            if arrayEvents.count == 0 {
                AlertInstance.instance.displayAlert(userMessage: "No Data Found")
            } else {
                let destViewController : AllEventsListVC = self.storyboard!.instantiateViewController(withIdentifier: "AllEventsListVC") as! AllEventsListVC
                destViewController.eventList = arrayEvents
                self.navigationController!.pushViewController(destViewController, animated: true)
            }
        }
    }
    //}
    
    func collectionVwUISetting(objCollectionVw:UICollectionView, layout:UICollectionViewFlowLayout) {
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        objCollectionVw.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        objCollectionVw.backgroundColor = UIColor.clear
        objCollectionVw.dataSource = self
        objCollectionVw.delegate  = self
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCell?
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 5, right: 0)
    }
}

extension UserEventsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (eventDetails != nil) ? (eventDetails?.eventData.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableVwUISetting(strIdentifier: "ShowPastEventsCell")
        let cell : ShowPastEventsCell = tableView.dequeueReusableCell(withIdentifier: "ShowPastEventsCell") as! ShowPastEventsCell
        cell.collectionVwTags.tag = indexPath.row
        self.collectionVwUISetting(objCollectionVw: cell.collectionVwTags, layout: cell.flowLayout)
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionVwTags.reloadData()
        cell.collectionViewHeightConst.constant = cell.collectionVwTags.collectionViewLayout.collectionViewContentSize.height
        self.configureEventCell(indexPath , cell)
        ADD_SHADOW_TO_BACK_VIEW(view: cell.vw_Background)
        ADD_SHADOW_TO_BACK_VIEW(view: cell.vw_VenueBackground)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objAddNewEventModel.isEventEdited = false
        self.moveToEventDetailScreen(index: indexPath.row)
    }
    
    func moveToEventDetailScreen(index:Int) {
        self.navigateToEventDetail(index)
    }
    
    func navigateToEventDetail(_ index:Int) {
        let eventDetail : EventDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "EventDetail") as! EventDetailVC
        eventDetail.eventIndividualDetail = eventDetails?.eventData[index]
        eventDetail.objDelegate = self
        eventDetail.indexToShowData = index
        eventDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventDetail, animated: true)
    }
}


// MARK: - Collection View Delegate and Data Source
extension UserEventsVC : UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (eventDetails != nil) ? (eventDetails?.eventData[collectionView.tag].category.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureTagCell(self.sizingCell!, collectionVw: collectionView, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        self.configureTagCell(cell, collectionVw: collectionView, forIndexPath: indexPath)
        return cell
    }
    
    func configureTagCell(_ cell: TagCell, collectionVw: UICollectionView, forIndexPath indexPath: IndexPath) {
        cell.tagName.text = eventDetails?.eventData[collectionVw.tag].category[indexPath.row].name
        cell.tagName.textAlignment = .center
        cell.backgroundColor = BLACK_COLOR
        cell.tagName.textColor = WHITE_COLOR
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToEventDetailScreen(index: collectionView.tag)
    }
    
    
    func configureEventCell(_ indexPath:IndexPath , _ cell:ShowPastEventsCell) {
        let eventInfo = eventDetails?.eventData[indexPath.row]
        //UserInfo
        cell.btnAddFav.isSelected = (eventInfo!.likeStatus == "0") ? false : true
        cell.img_MyProfile.sd_setImage(with: URL.init(string: (eventInfo!.eventOwnerInfo?.profilePic)!), placeholderImage:#imageLiteral(resourceName: "userDummy"))
        cell.lbl_Title.text = eventInfo!.eventOwnerInfo?.name
        //EventInfo
        cell.img_Event.sd_setImage(with: URL.init(string: (eventInfo!.image)), placeholderImage:#imageLiteral(resourceName: "ic_noImage"))
        cell.lbl_EventTitle.text = eventInfo!.title.capitalized.decode()
        cell.lbl_EventAddress.text = eventInfo!.location
        cell.lbl_EventDateAndTime.text = "\(super.returnDate(((eventInfo!.start_date))))"
        cell.lbl_EventTime.text = "Ends On: \(super.returnDate(((eventInfo!.end_date))))"
        cell.btnShowMembersList.tag = indexPath.row
        cell.btnShowMembersList.addTarget(self, action: #selector(showAllMembers(_:)), for: .touchUpInside)
        cell.btnAddFav.tag = indexPath.row
        cell.btnAddFav.addTarget(self, action: #selector(btnLikeEventAct(_:)), for: .touchUpInside)
        let standardCount : Int = 5
        cell.lbl_membersCount.isHidden = (Int(eventInfo!.no_members)! > standardCount) ? false : true
        cell.lbl_membersCount.text = (Int(eventInfo!.no_members)! > standardCount) ? "+\(Int(eventInfo!.no_members)!-5)\n more" : ""
        for item in cell.viewForImages.subviews {
            if item.isKind(of: UIImageView.self) {
                item.removeFromSuperview()
            }
        }
        var originX : CGFloat = 0
        let imagesCount : Int = (eventInfo!.members.count > standardCount) ? standardCount : eventInfo!.members.count
        for index in 0..<imagesCount {
            let imgVw = UIImageView(frame: CGRect(x: originX, y: 0, width: cell.viewForImages.frame.height, height: cell.viewForImages.frame.height))
            imgVw.sd_setImage(with: URL.init(string: (eventInfo!.members[index].profileImage!)), placeholderImage:#imageLiteral(resourceName: "userDummy"))
            imgVw.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
            imgVw.layer.borderWidth = 1
            imgVw.clipsToBounds=true
            imgVw.layer.cornerRadius = (cell.viewForImages.frame.height)/2
            cell.viewForImages.addSubview(imgVw)
            originX += CGFloat(cell.viewForImages.frame.height-18)
        }
    }
    
    @objc func showAllMembers(_ sender: UIButton) {
        self.getMembersListAPI(parameters: ["event_id":(eventDetails?.eventData[sender.tag].event_id)!,"access_token":loggedInUser?.accessToken ?? "0" ])
    }
    
    @objc func btnLikeEventAct(_ sender: UIButton) {
        self.changeEventLikeStatus(index: sender.tag, isCollectionVw: false, likeStatus: "")
        self.callLikeUnlikeEventAPI(parameters: ["id":(eventDetails?.eventData[sender.tag].event_id)!,"access_token":loggedInUser?.accessToken ?? "0" ], tag: sender.tag, isCollection: false)
    }
    
    func changeEventLikeStatus(index:Int, isCollectionVw:Bool, likeStatus:String) {
        if likeStatus.count > 0{
            eventDetails?.eventData[index].likeStatus = likeStatus
        } else {
            eventDetails?.eventData[index].likeStatus = (eventDetails?.eventData[index].likeStatus == "0") ? "1" : "0"
        }
        self.tblvwEvents.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

// calling "get_events API"
extension UserEventsVC {
    func callGetEvents(isShowLoader : Bool) {
        if !isShowLoader {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        let parameters : [String : String] = ["access_token" : loggedInUser?.accessToken ?? "0",
                                              "event_by":"me",
                                              "page_no":"0",
                                              "no_of_post":"100"]
        httpPost(request: getEventListAPI, params: parameters, isShowLoader: isShowLoader, forView: self.view, successHandler: { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response["code"].stringValue == "200" {
                print(response)
                self.eventDetails = EventDetails(dictionary: response)
                self.setViewAfterAPICall()
                self.likedPageCntrl.numberOfPages = (self.eventDetails?.likedEvents.count)!
                self.carouselVw.reloadData()
                self.tblvwEvents.reloadData()
            } else {
                super.messageChecking(strMessage: response["message"].stringValue, strCode: response["code"].stringValue)
            }
        }) { (Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("FETCH NEWS FEEDS API Error: \(String(describing: Error?.localizedDescription))")
            AlertInstance.instance.displayAlert(userMessage:(Error?.localizedDescription)!)
        }
    }
    
    // MARK: - WBS Method
    func getMembersListAPI(parameters : [String : String]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        httpPost(request: eventMembersListAPI, params: parameters, isShowLoader: true, forView: self.view, successHandler: { (response) in
            //print(response)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response["code"].stringValue == "200" {
                var membersList = [ExistingUsers]()
                let list = response["data"].arrayValue
                // .removeAll()
                for friend in list {
                    let friendData = ExistingUsers.init(existingUsers: friend)
                    membersList.append(friendData)
                }
                if membersList.count > 0 {
                    super.moveToPostLikeScreen(isLikedScreen: Title.membersList.rawValue, postData: membersList)
                } else {
                    SHOW_ALERT_CONTROLLER_SINGLE_BUTTON(alertTitle: APPNAME, message: response["message"].stringValue, btnTitle: "Dismiss", viewController: self, completionHandler: { (success) in
                    })
                }
            } else {
                super.messageChecking(strMessage: response["message"].stringValue, strCode: response["code"].stringValue)
            }
        }) { (Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            AlertInstance.instance.displayAlert(userMessage: (Error?.localizedDescription)!)
            print("LIKE DISLIKE FEEDS API Error: \(String(describing: Error?.localizedDescription))")
        }
    }
    
    // MARK: - WBS Method
    func callLikeUnlikeEventAPI(parameters : [String : String], tag:Int, isCollection:Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print(parameters)
        httpPost(request: likeUnLikeEventAPI, params: parameters, isShowLoader: false, forView: self.view, successHandler: { (response) in
            //print(response)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response["code"].stringValue == "200" {
                self.changeEventLikeStatus(index: tag, isCollectionVw: isCollection, likeStatus: response["like"].stringValue)
                self.callGetEvents(isShowLoader: (self.eventDetails == nil) ? true : false)
            } else {
                super.messageChecking(strMessage: response["message"].stringValue, strCode: response["code"].stringValue)
            }
        }) { (Error) in
            self.changeEventLikeStatus(index: tag, isCollectionVw: isCollection, likeStatus: "")
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            AlertInstance.instance.displayAlert(userMessage: (Error?.localizedDescription)!)
        }
    }
    
    func setViewAfterAPICall() {
        if ((eventDetails?.likedEvents.count)! > 0) && ((eventDetails?.eventData.count)! > 0) {
            self.viewLIkedEventHeightConst.constant = 300
            self.viewCreateEventHeightConst.constant  = 50
            self.viewYourEvents.isHidden=false
            self.viewAllempty.isHidden=true
        } else if ((eventDetails?.likedEvents.count)! == 0) && ((eventDetails?.eventData.count)! == 0) {
            self.viewInitialSetup()
        }  else if ((eventDetails?.likedEvents.count)! == 0) && ((eventDetails?.eventData.count)! > 0) {
            self.viewLIkedEventHeightConst.constant = 0
            self.viewCreateEventHeightConst.constant  = 50
            self.viewYourEvents.isHidden=false
            self.viewAllempty.isHidden=true
        } else if ((eventDetails?.likedEvents.count)! > 0) && ((eventDetails?.eventData.count)! == 0) {
            self.viewLIkedEventHeightConst.constant = 300
            self.viewCreateEventHeightConst.constant  = 0
            self.viewYourEvents.isHidden=true
            self.viewAllempty.isHidden=false
            self.viewAllEmptyTopConst.constant  = self.viewHeaderHeightConst.constant + self.viewLIkedEventHeightConst.constant + self.viewLIkedEventHeightConst.constant + 50
        }
        self.viewLIkedEvents.isHidden = (self.viewLIkedEventHeightConst.constant == 0) ? true : false
        self.view.layoutIfNeeded()
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: { _ in })
    }
    
    @objc func btnGoingFrndsAct(_ sender: UIButton) {
        let id : Int = Int(sender.title(for: .normal)!)!
        print(id)
        self.getMembersListAPI(parameters: ["event_id":(eventDetails?.likedEvents[id].event_id)!,"access_token":loggedInUser?.accessToken ?? "0" ])
    }
}

extension UserEventsVC : EventDetailsDelegate {
    func passingIdToRemoveEvent(_ index: Int) {
        self.eventDetails?.eventData.remove(at: index)
        self.setViewAfterAPICall()
        self.tblvwEvents.reloadData()
    }
}

extension UserEventsVC : iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return (self.eventDetails == nil) ? 0 : (self.eventDetails?.likedEvents.count)!
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
       // var label: UILabel
        var btnLike : UIButton
        var itemView: UIImageView
        var lblTitle : UILabel
        var lblLocation : UILabel
        var lblEventDate : UILabel
        //var lblGoing : UILabel
        var viewGoingFrnds : UIView
        var btnGoingFrnds : UIButton
        //var imgVwLocation : UIImageView
       // var imgVwEventDate : UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //  get a reference to the label in the recycled view
            btnLike = itemView.viewWithTag(1) as! UIButton
            lblTitle = itemView.viewWithTag(2) as! UILabel
            lblLocation = itemView.viewWithTag(3) as! UILabel
            lblEventDate = itemView.viewWithTag(4) as! UILabel
//            lblGoing = itemView.viewWithTag(5) as! UILabel
            btnGoingFrnds = itemView.viewWithTag(6) as! UIButton
            viewGoingFrnds = itemView.viewWithTag(7) as! UIView
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: carouselVw.frame.origin.x+15, y: viewLIkedEvents.frame.origin.y+60, width: carouselVw.frame.width-30, height: viewLIkedEventHeightConst.constant-100))
            itemView.contentMode = .scaleAspectFill
            itemView.backgroundColor = UIColor.clear
            itemView.clipsToBounds=true
            itemView.layer.cornerRadius = 12
            
            let itemViewBlur = UIImageView(frame: CGRect(x: 0, y: 0, width: itemView.frame.width, height: itemView.frame.height))
            itemViewBlur.contentMode = .scaleAspectFill
            itemViewBlur.backgroundColor = UIColor.black.withAlphaComponent(0.35)
            itemViewBlur.clipsToBounds=true
            itemViewBlur.layer.cornerRadius = 12
            
            btnLike = UIButton(frame: CGRect(x: itemView.frame.width-40, y: 0, width: 40, height: 35))
            btnLike.addTarget(self, action: #selector(btnLikeExploreEventAct(_:)), for: .touchUpInside)
            btnLike.tintColor = UIColor.white
            btnLike.setImage(UIImage.init(imageLiteralResourceName: "ic_notLiked"), for: .normal)
            btnLike.setImage(UIImage.init(imageLiteralResourceName: "Liked"), for: .selected)
            btnLike.tag = 1
            
            lblTitle = UILabel(frame: CGRect(x: 5, y: 20, width: itemView.frame.width-10, height: 40))
            lblTitle.numberOfLines = 2
            lblTitle.font = UIFont(name: Constants.AppFont.fontHelveticaBold, size: 18.0)
            lblTitle.textColor = UIColor.white
            lblTitle.textAlignment  = .center
            lblTitle.tag = 2
            
            let imgVwLocation = UIImageView(frame: CGRect(x: itemView.frame.origin.x, y: lblTitle.frame.maxY, width: 25, height: 25))
            imgVwLocation.contentMode = .center
          //  imgVwLocation.backgroundColor = .red
            imgVwLocation.image = UIImage.init(imageLiteralResourceName: "pinCarousel")
            
            lblLocation = UILabel(frame: CGRect(x: (imgVwLocation.frame.origin.x+imgVwLocation.frame.width)+3, y: lblTitle.frame.maxY, width: itemView.frame.width-(imgVwLocation.frame.width+25), height: 40))
            lblLocation.numberOfLines = 2
            lblLocation.font = UIFont(name: Constants.AppFont.fontHelveticaNeue, size: 14.0)
            lblLocation.textColor = UIColor.white
//            lblLocation.backgroundColor = .green
            lblLocation.textAlignment  = .left
            lblLocation.tag = 3
            
            let imgVwEventDate = UIImageView(frame: CGRect(x: itemView.frame.origin.x, y: lblLocation.frame.maxY+3, width: 25, height: 25))
            imgVwEventDate.contentMode = .center
          //  imgVwEventDate.backgroundColor = .red
            imgVwEventDate.image = UIImage.init(imageLiteralResourceName: "CalendarCarousel")
            imgVwEventDate.clipsToBounds=true
            
            lblEventDate = UILabel(frame: CGRect(x: (imgVwEventDate.frame.origin.x+imgVwEventDate.frame.width)+3, y: lblLocation.frame.maxY+3, width: itemView.frame.width-(imgVwEventDate.frame.width+25), height: 40))
            lblEventDate.numberOfLines = 2
            lblEventDate.textAlignment  = .left
           // lblEventDate.backgroundColor = .green
            lblEventDate.font = UIFont(name: Constants.AppFont.fontHelveticaNeue, size: 14.0)
            lblEventDate.textColor = UIColor.white
            lblEventDate.tag = 4
            
            let lblGoing =  UILabel(frame: CGRect(x: itemView.frame.origin.x, y: lblEventDate.frame.maxY+3, width: 70, height: 18))
            lblGoing.textAlignment  = .left
         //   lblGoing.backgroundColor = .green
            lblGoing.font = UIFont(name: Constants.AppFont.fontHelveticaNeue, size: 14.0)
            lblGoing.textColor = UIColor.white
            lblGoing.text = "Going"
            lblGoing.tag = 5
            
            btnGoingFrnds = UIButton(frame: CGRect(x: itemView.frame.width-40, y: itemView.frame.height-40, width: 40, height: 40))
            btnGoingFrnds.addTarget(self, action: #selector(btnGoingFrndsAct(_:)), for: .touchUpInside)
            btnGoingFrnds.setTitleColor(UIColor.clear, for: .normal)
          // btnGoingFrnds.setTitle("...", for: .normal)
          // btnGoingFrnds.setBackgroundImage(UIImage.init(imageLiteralResourceName: "ic_dots"), for: .normal)
          // btnGoingFrnds.backgroundColor = UIColor.red
          // btnGoingFrnds.titleLabel?.font = UIFont(name: Constants.AppFont.fontHelveticaBold, size: 24.0)!
            btnGoingFrnds.tag = 6
            viewGoingFrnds = UIView(frame: CGRect(x: itemView.frame.origin.x, y: lblGoing.frame.maxY+3, width: 160, height: 45))
            viewGoingFrnds.tag = 7
          // viewGoingFrnds.backgroundColor = UIColor.green
            var originX : CGFloat = 0
            let standardCount : Int = 5
            for _ in 0..<standardCount {
                let imgVw = UIImageView(frame: CGRect(x: originX, y: 0, width: 25, height: 25))
                imgVw.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
                imgVw.layer.borderWidth = 1
                imgVw.clipsToBounds=true
                imgVw.layer.cornerRadius = 12.5
                imgVw.backgroundColor = UIColor.clear
                viewGoingFrnds.addSubview(imgVw)
                originX += CGFloat(imgVw.frame.height-10)
            }
            itemView.addSubview(itemViewBlur)
            itemView.addSubview(btnLike)
            itemView.addSubview(lblTitle)
            itemView.addSubview(imgVwLocation)
            itemView.addSubview(lblLocation)
            itemView.addSubview(imgVwEventDate)
            itemView.addSubview(lblEventDate)
            itemView.addSubview(lblGoing)
            itemView.addSubview(viewGoingFrnds)
            itemView.addSubview(btnGoingFrnds)
        }
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        itemView.sd_setImage(with: URL.init(string: (self.eventDetails?.likedEvents[index].image)!), placeholderImage:#imageLiteral(resourceName: "userDummy"))
        btnLike.isSelected = (self.eventDetails?.likedEvents[index].likeStatus == "0") ? false : true
        lblTitle.text = self.eventDetails?.likedEvents[index].title.decode()
        lblLocation.text = self.eventDetails?.likedEvents[index].location
        lblEventDate.text = "\(super.returnDateInLongFormat((((self.eventDetails?.likedEvents[index].start_date)!))))" + " to \(super.returnDateInLongFormat((((self.eventDetails?.likedEvents[index].end_date)!))))"
        btnGoingFrnds.setTitle("\(index)", for: .normal)
        for index1 in 0..<viewGoingFrnds.subviews.count {
            let imgVw = viewGoingFrnds.subviews[index1] as! UIImageView
            if ((self.eventDetails?.likedEvents[index].members.count)!) > index1 {
                imgVw.sd_setImage(with: URL.init(string:((self.eventDetails?.likedEvents[index].members[index1].profileImage)!)), placeholderImage:#imageLiteral(resourceName: "userDummy"))
            }
        }
        itemView.tag = index+10000
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let eventDetail : EventDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "EventDetail") as! EventDetailVC
        eventDetail.eventIndividualDetail = eventDetails?.likedEvents[index]
        eventDetail.indexToShowData = index
        eventDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventDetail, animated: true)
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        if carousel.currentItemView?.tag != nil {
            likedPageCntrl.currentPage = ((carousel.currentItemView?.tag)!-10000)
        }
    }
    
//    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
//        likedPageCntrl.currentPage = (carousel.currentItemView?.tag)!
//    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        // likedPageCntrl.currentPage = carousel.tag
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    @objc func btnLikeExploreEventAct(_ sender: UIButton) {
       // self.changeEventLikeStatus(index: sender.tag, isCollectionVw: true, likeStatus: "")
       // self.callLikeUnlikeEventAPI(parameters: ["id":(eventDetails?.eventExploreData[sender.tag].event_id)!,"access_token":loggedInUser?.accessToken ?? "0" ], tag: sender.tag, isCollection: true)
    }
}
