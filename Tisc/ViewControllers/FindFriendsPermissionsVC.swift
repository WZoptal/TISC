//
//  FindFriendsPermissionsVC.swift
//  Tisc
//
//  Created by Eshan Cheema on 23/10/18.
//  Copyright © 2018 Eshan Cheema. All rights reserved.
//

import UIKit
import Contacts
class FindFriendsPermissionsVC: BaseViewController {
    // MARK: - Outlets Declarations
    @IBOutlet weak var btn_FindFriends: UIButton!
    // MARK: - Variable Declarations
    var arrOfContactsServer = [Dictionary<String, String>]()
    var array_InviteFriends = [InviteFriends]()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialSetUp()
        // Do any additional setup after loading the view.
    }
    
    func presentSettingsActionSheet() {
        let alert = UIAlertController(title: "Permission to Contacts", message: "This app needs access to contacts in order to ...", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func viewInitialSetUp(){
        CREATE_ROUND_CORNER_BUTTON(button: btn_FindFriends, cornerRadius: 0.0, bgColor: CLEAR_COLOR, borderWidth: 0.0, borderColor: CLEAR_COLOR)
        ADD_SHADOW_TO_BUTTON(button: btn_FindFriends)
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .denied || status == .restricted {
            presentSettingsActionSheet()
            return
        }
        var contacts = [CNContact]()
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                DispatchQueue.main.async {
                    self.presentSettingsActionSheet()
                }
                return
            }
            
            // get the contacts
            
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as NSString, CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    contacts.append(contact)
                }
                print(contacts.count)
            } catch {
                print(error)
            }
            
            // do something with the contacts array (e.g. print the names)
            
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            for contact in contacts {
                let array_phoneNumber = contact.phoneNumbers
                if array_phoneNumber.count > 0 {
                    let strContact = array_phoneNumber[0].value.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
                    let formattedString = strContact.replacingOccurrences(of: " ", with: "")
                    let dict_InviteFriendsDetail = ["number" : formattedString, "name" : formatter.string(from: contact) ?? "???", "isSelected" : "0"]
                    let contactsLocal  = InviteFriends.init(inviteFriendsData: dict_InviteFriendsDetail)
                    self.array_InviteFriends.append(contactsLocal)
                }
            }
        }
    }
    // MARK: - Button Actions
    @IBAction func tappedFindFriends(_ sender: Any) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .denied || status == .restricted {
            presentSettingsActionSheet()
            return
        }
        if array_InviteFriends.count > 0 {
            for index in 0..<array_InviteFriends.count {
                let dict = ["name":array_InviteFriends[index].friendName , "phone":array_InviteFriends[index].friendNumber]
                arrOfContactsServer.append(dict as! [String : String])
            }
            self.saveContactList()
        } else {
            self.moveToNextScreen([])
        }
    }
}

// Save all thec ocntacts to server
extension FindFriendsPermissionsVC {
    func saveContactList() {
        let parameters : [String : Any] = ["access_token" : loggedInUser?.accessToken ?? "0", "contacts":self.arrOfContactsServer]
        httpPostForRaw(request: savePhoneContactAPI, params: parameters,isShowLoader: true,forView: self.view, successHandler: { (response) in
            print(response)
            if response["code"].stringValue == "200" {
                self.getContactList(isUserSignedUp:true)
            } else {
                super.messageChecking(strMessage: response["message"].stringValue, strCode: response["code"].stringValue)
            }
        }) { (Error) in
            AlertInstance.instance.displayAlert(userMessage:(Error?.localizedDescription)!)
        }
    }
    
    func moveToNextScreen(_ contactList:[ExistingUsers]) {
        let findFriends = self.storyboard?.instantiateViewController(withIdentifier: "FindFriends") as! FindFriendsVC
        findFriends.array_InviteFriends = contactList
        findFriends.isUserSigningUp = true
        self.navigationController?.pushViewController(findFriends, animated: true)
    }
}
