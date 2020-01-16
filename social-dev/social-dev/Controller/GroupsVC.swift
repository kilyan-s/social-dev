//
//  SecondViewController.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 13/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    //Outlets
    @IBOutlet weak var tableview: UITableView!
    
    //Var
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    //Func
    
    //Actions


}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return groups.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell() }
        
        //let group = groups[indexPath.row]
        cell.configureCell(withTitle: "Title", andDescription: "Description", numberOfMembers: 5)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
