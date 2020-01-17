//
//  CreateGroupVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class CreateGroupVC: UIViewController {
    //Outlets
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    //Variables
    var emailArray = [String]()
    var chosenUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
        IQKeyboardManager.shared.enable = false
    }
    
    //Actions
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTextField.text != nil && descriptionTextField.text != nil && chosenUsers.count > 0 {
            DataService.instance.getIds(forUsernames: chosenUsers) { (userIds) in
                var allIds = userIds
                //Append current user to the group since he is not selected in the list
                allIds.append(Auth.auth().currentUser!.uid)
                
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: allIds) { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created")
                    }
                }
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" {
            emailArray = []
            tableview.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!) { (resultEmailArray) in
                self.emailArray = resultEmailArray
                self.tableview.reloadData()
            }
        }
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImg = UIImage(named: "defaultProfileImage")
        let email = emailArray[indexPath.row]
        var userIsSelected = false
        
        //Check if email is already selected
        if chosenUsers.contains(email) {
            userIsSelected = true
        }
        
        cell.configureCell(withProfileImg: profileImg!, andEmail: email, andIsSelected: userIsSelected)
        
        //If user is selected, select this cell for didSelect and didDeselect actions to work properly
        if userIsSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        cell.updateSelectedStatus(isSelected: true)
        
        chosenUsers.append(cell.emailLbl.text!)
        groupMemberLbl.text = chosenUsers.joined(separator: ", ")
        doneBtn.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        cell.updateSelectedStatus(isSelected: false)
        
        chosenUsers = chosenUsers.filter({ $0 != cell.emailLbl.text!})
        if chosenUsers.count > 0 {
            groupMemberLbl.text = chosenUsers.joined(separator: ", ")
        } else {
            groupMemberLbl.text = "Add members to your group"
            doneBtn.isHidden = true
        }
    }
}

extension CreateGroupVC: UITextFieldDelegate {
    
}
