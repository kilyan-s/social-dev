//
//  GroupFeedVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 16/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var navbarTitleLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTxtField: InsetTextField!
    @IBOutlet weak var messageSendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        messageView.bindToKeyboard()
    }
    
    //MARK: Actions
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
