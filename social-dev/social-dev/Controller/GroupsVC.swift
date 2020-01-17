//
//  SecondViewController.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 13/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: Var
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (groupSnapshot) in
            DataService.instance.getAllGroups { (resultGroups) in
                self.groups = resultGroups
                self.tableview.reloadData()
            }
        }
    }
    
    //MARK: Func
    
    //MARK: Actions


}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell() }
        
        let group = groups[indexPath.row]
        cell.configureCell(withTitle: group.title, andDescription: group.descr, numberOfMembers: group.memberCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup = groups[indexPath.row]
        
        guard let groupFeedVC = storyboard?.instantiateViewController(identifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initData(forGroup: selectedGroup)
        //present(groupFeedVC, animated: true, completion: nil )
        presentDetail(groupFeedVC)
    }
}
