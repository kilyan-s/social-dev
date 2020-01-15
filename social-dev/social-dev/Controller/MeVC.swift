//
//  MeVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    //Actions
    @IBAction func logoutBtnWasPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout ?", message: "Are you sure you want to logout ?", preferredStyle: .actionSheet)
        
        //Logout btn
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
                
            } catch {
                print(error)
            }
        }
        
        logoutPopup.addAction(logoutAction)
        
        //Cancel btn
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in }
        logoutPopup.addAction(cancelAction)
        
        present(logoutPopup, animated: true, completion: nil)
    }
}
