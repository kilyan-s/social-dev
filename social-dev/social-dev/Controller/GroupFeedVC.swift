//
//  GroupFeedVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 16/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var navbarTitleLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTxtField: InsetTextField!
    @IBOutlet weak var messageSendBtn: UIButton!
    
    //MARK: Var
    var group: Group?
    var messages = [Message]()
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageView.bindToKeyboard()
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navbarTitleLbl.text = group?.title
        
        DataService.instance.getEmails(forUIDs: group!.members) { (emailsArr) in
            self.membersLbl.text = emailsArr.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (groupsSnapshot) in
            DataService.instance.getAllMessages(forGroup: self.group!) { (resultGroupMsg) in
                self.messages = resultGroupMsg
                self.tableview.reloadData()
                
                if self.messages.count > 0 {
                    self.tableview.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
                }
            }
        }
    }
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    //MARK: Actions
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        print("sendBtnWasPressed")
        if messageTxtField.text != nil {
            messageTxtField.isEnabled = false
            messageSendBtn.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: messageTxtField.text!, forUid: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (success) in
                if success {
                    print("message sent")
                    self.messageTxtField.text = ""
                } else {
                    print("unable to send message")
                }
                self.messageTxtField.isEnabled = true
                self.messageSendBtn.isEnabled = true
            }
        }
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: image!, email: email, content: message.content)
        }
        return cell
    }
}
