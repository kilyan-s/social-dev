//
//  CreateGroupVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {
    //Outlets
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Actions
    @IBAction func closeBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
    }
    
}
